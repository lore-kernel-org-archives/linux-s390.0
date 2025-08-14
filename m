Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870527A12B;
	Thu, 14 Aug 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156325; cv=none; b=KW28gAdGu6Ty71MVKZ+S7NhXO/zDea1bbUnpXBRQkRddZ3qmiBLHn0l55Vc9bLK69QypThCfkksQG9aYmirUPt2K0d4Yf4HmFWGA5SFNNpB1Y2oXcHrTz+Zfw/b1vHpg3Fb+np6GuA9pHnTawvc/yBGLR9joNB8w68D1BsdXO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156325; c=relaxed/simple;
	bh=dcZVeE1ooG0iHensGTvf7QUr3epXcu5dw0Q3AjF9SyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1CsNhnI7CYn2fDP0kE+LEOq6ASuBiSdjdrcREnh2sQeyeW0kJKfCrmoDlHOI8NORcsIhCBjDMY6Kb+enBm7XfwU1ATfncUFKN+TEe64agVtezqFnKCO4KaqOdSNA1VRAJQs48Nozi9xrgsyXrEKoFegArFdhv32XwmSuCZrNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTw9pk9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTw9pk9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB67C4CEF5;
	Thu, 14 Aug 2025 07:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156325;
	bh=dcZVeE1ooG0iHensGTvf7QUr3epXcu5dw0Q3AjF9SyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTw9pk9zEckH+7fhLTV/dF3QHgE5Qjnw//AyXwLQY0t6rJ1RQ/hyummnbTP0FAtS0
	 P4zi3z8CbNGXisvLpRFU0MIOWMMABpulcHjZyKObuwNURgSdso/XMdCk05FSuHjpSe
	 8ci15YRw+0v0b/qaXaUHH0ToZiCRRH1TIdIItx0dOXw40/jujFv4+zfgSJFgcHSk6c
	 VF+Nent4sc4euKVAGluE0uMfGm4ZKcly2c/6brM/UN3m/oWqpQ05rgsyUIh418kClc
	 +9w+OlLcZsYKjaXxAco1HnsK1uaJ9vsvMn7tvmMPUGq0Pl6U4gK7StNaPNnyLXdfEv
	 VYjpN9qyHkqKg==
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
Subject: [PATCH 16/16] s390/char/con3270: use tty_port_tty guard()
Date: Thu, 14 Aug 2025 09:24:56 +0200
Message-ID: <20250814072456.182853-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the new tty_port_tty guard, use it in tty3270_resize(). This
makes the code easier to read. The winsize is now defined in the
scope and initialized immediately, so that it's obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
---
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3270.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index b78b86e8f281..a367f95c7c53 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -970,8 +970,6 @@ static void tty3270_resize(struct raw3270_view *view,
 	char **old_rcl_lines, **new_rcl_lines;
 	char *old_prompt, *new_prompt;
 	char *old_input, *new_input;
-	struct tty_struct *tty;
-	struct winsize ws;
 	size_t prompt_sz;
 	int new_allocated, old_allocated = tp->allocated_lines;
 
@@ -1023,14 +1021,14 @@ static void tty3270_resize(struct raw3270_view *view,
 	kfree(old_prompt);
 	tty3270_free_recall(old_rcl_lines);
 	tty3270_set_timer(tp, 1);
-	/* Informat tty layer about new size */
-	tty = tty_port_tty_get(&tp->port);
-	if (!tty)
-		return;
-	ws.ws_row = tty3270_tty_rows(tp);
-	ws.ws_col = tp->view.cols;
-	tty_do_resize(tty, &ws);
-	tty_kref_put(tty);
+	/* Inform the tty layer about new size */
+	scoped_guard(tty_port_tty, &tp->port) {
+		struct winsize ws = {
+			.ws_row = tty3270_tty_rows(tp),
+			.ws_col = tp->view.cols,
+		};
+		tty_do_resize(scoped_tty(), &ws);
+	}
 	return;
 out_screen:
 	tty3270_free_screen(screen, new_rows);
-- 
2.50.1

