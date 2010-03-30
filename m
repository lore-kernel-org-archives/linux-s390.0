Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Mar 2010 19:45:42 +0300
From: Dan Carpenter <error27@gmail.com>
Subject: [patch v2] s390: potential buffer overflow
Message-ID: <20100330164542.GN5069@bicker>
References: <20100330094342.GJ5069@bicker> <m1k4strd42.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k4strd42.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

"len" hasn't been properly range checked so we shouldn't use it as an
array offset.  This can only be written to by root but it would still be
annoying to accidentally write more than 3 characters and corrupt your
memory.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2.  Removed a superfluous chunk from my first patch.  I didn't
understand how ->maxlen worked.

diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index f449c69..38a9f55 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -84,7 +84,7 @@ static int proc_handler_callhome(struct ctl_table *ctl, int write,
 		rc = copy_from_user(buf, buffer, sizeof(buf));
 		if (rc != 0)
 			return -EFAULT;
-		buf[len - 1] = '\0';
+		buf[sizeof(buf) - 1] = '\0';
 		if (strict_strtoul(buf, 0, &val) != 0)
 			return -EINVAL;
 		if (val != 0 && val != 1)
