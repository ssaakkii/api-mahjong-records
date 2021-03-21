from unittest.mock import patch

from django.core.management import call_command
from django.db.utils import OperationalError
from django.test import TestCase


class CommandTests(TestCase):

	def test_wait_for_db_ready(self):
		"""Test waiting for db when db is available"""

		with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:

			# Mock の返り値を設定
			gi.return_value = True
			# python manage.py wait_for_db と同義（変数に受ければ返り値を取得することも可能）
			call_command('wait_for_db')
			# Mockオブジェクトが何回呼ばれたかをチェック
			self.assertEqual(gi.call_count, 1)

	@patch('time.sleep', return_value=True)
	def test_wait_for_db(self, ts):
		"""Test waiting for db"""

		with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:

			# 5回 OperationalError を発生させる
			gi.side_effect = [OperationalError] * 5 + [True]
			call_command('wait_for_db')
			self.assertEqual(gi.call_count, 6)
