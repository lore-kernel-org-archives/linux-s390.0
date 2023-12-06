Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AD16429;
	Wed,  6 Dec 2023 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXsENStk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFF6C433C8;
	Wed,  6 Dec 2023 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848259;
	bh=r12fMU0BW1YaP5gO3VGkmDOu28jE14hYoJXFZVc2/YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXsENStkdWXfRJe/+InQiCO341yd8klGCOU5x6uZVyfrQVZRYdL1l5LU7nizPpJEe
	 UJWPcd8kRnPlvjK2UET/moJZjwN52VYpiGduoQCooyNYMaw0z9Jt4KyH6RRZNl7+Lk
	 pxy1F3jHndTaZ/qvuN1FjIWlzTcmE/rZ9kZnG+z/o9XJmej3soOUGfbNLnnq7ZRghP
	 EXa2iEZnOjGEKlPj/G2OvQ2fRBhR/zWp3lGVe9wCJvlbc5VoOb+baU4XG3/QS0zpcJ
	 GiSiT+JO4Gu3xJ7fL5LNs7kvMat7E4po4tpl+8q6+sEdsEdwdbn1B9RFkY/9ReKcQG
	 cHcfEjlCsZN8g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 09/27] tty: con3270: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:54 +0100
Message-ID: <20231206073712.17776-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3270.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 363315fa1666..251d2a1c3eef 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -54,7 +54,7 @@ struct tty3270_attribute {
 };
 
 struct tty3270_cell {
-	unsigned char character;
+	u8 character;
 	struct tty3270_attribute attributes;
 };
 
@@ -123,7 +123,7 @@ struct tty3270 {
 
 	/* Character array for put_char/flush_chars. */
 	unsigned int char_count;
-	char char_buf[TTY3270_CHAR_BUF_SIZE];
+	u8 char_buf[TTY3270_CHAR_BUF_SIZE];
 };
 
 /* tty3270->update_flags. See tty3270_update for details. */
@@ -1255,7 +1255,7 @@ static unsigned int tty3270_write_room(struct tty_struct *tty)
  * Insert character into the screen at the current position with the
  * current color and highlight. This function does NOT do cursor movement.
  */
-static void tty3270_put_character(struct tty3270 *tp, char ch)
+static void tty3270_put_character(struct tty3270 *tp, u8 ch)
 {
 	struct tty3270_line *line;
 	struct tty3270_cell *cell;
@@ -1561,7 +1561,7 @@ static void tty3270_goto_xy(struct tty3270 *tp, int cx, int cy)
  *  Pn is a numeric parameter, a string of zero or more decimal digits.
  *  Ps is a selective parameter.
  */
-static void tty3270_escape_sequence(struct tty3270 *tp, char ch)
+static void tty3270_escape_sequence(struct tty3270 *tp, u8 ch)
 {
 	enum { ES_NORMAL, ES_ESC, ES_SQUARE, ES_PAREN, ES_GETPARS };
 
@@ -1726,7 +1726,7 @@ static void tty3270_escape_sequence(struct tty3270 *tp, char ch)
  * String write routine for 3270 ttys
  */
 static void tty3270_do_write(struct tty3270 *tp, struct tty_struct *tty,
-			     const unsigned char *buf, int count)
+			     const u8 *buf, size_t count)
 {
 	int i_msg, i;
 
@@ -2052,7 +2052,7 @@ con3270_write(struct console *co, const char *str, unsigned int count)
 {
 	struct tty3270 *tp = co->data;
 	unsigned long flags;
-	char c;
+	u8 c;
 
 	spin_lock_irqsave(&tp->view.lock, flags);
 	while (count--) {
-- 
2.43.0

