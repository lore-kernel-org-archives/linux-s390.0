Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 19/29] s390/tty3270: Avoid comma separated statements
Date: Mon, 24 Aug 2020 21:56:16 -0700
Message-Id: <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/char/tty3270.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index aec996de44d9..6acce975df26 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
 			 * last output position matches the start address
 			 * of this line.
 			 */
-			if (s->string[1] == sba[0] && s->string[2] == sba[1])
-				str += 3, len -= 3;
+			if (s->string[1] == sba[0] && s->string[2] == sba[1]) {
+				str += 3;
+				len -= 3;
+			}
 			if (raw3270_request_add_data(wrq, str, len) != 0)
 				break;
 			list_del_init(&s->update);
-- 
2.26.0
