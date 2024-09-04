Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357944376
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471103; cv=none; b=Ia7YAcDN1DbCJ9gTKBsauRfevKGCV6gnAbLnBzjQSK/i5wLWQtc0rUswWnF4vD2sQwc9fQbOe/UNmO3MXoWqsS3x2+kcJwiswZMuh+fYpH0CnTG3wQD7GSW/lZCcRWkdiLnJtReq4DVuYjoFt64aR4WdZzSLwcfF3GDeXo7ulTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471103; c=relaxed/simple;
	bh=yaEz2KraSG/YjcPO59acPqjQIFENGs47hLYDhx+curM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQ3aikFU4QqO4mzIvDIen7D5K2YtZ7kZX9vgMrcwRbjb8gNQ3XbqTSXg2gaatzVKB8959kYMwjgrfMnPYg/MBW+P8NP1OnxE3t7Umg0LNHF6585ACGl6Okqv2TlBncU0ac2Y9eQJ4wowUHpjrNCFp/ztCYtVC6l9TkhtBUqjEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfaxAxex; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=veOGcoL4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfaxAxex; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=veOGcoL4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfaxAxex";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="veOGcoL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfaxAxex";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="veOGcoL4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CB051F7DB;
	Wed,  4 Sep 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725471099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1tyhSHPGeGNPrKi4QSR+hpD0VnX4AnAsJWt+sL5cNOw=;
	b=vfaxAxexjHuSZaI8f5HtEYwRLLdJFMnCUN/4Yv8bJ8ryAFFOyRc2C4tc+byKv7UZM0LCo6
	TlGvk2dKDqXbfMXpNdtw1om2LJNgkbsPSWN1EkAx7YWbRvZvOKdX4qTwG45Xl+WmhX0ect
	jqsmA/67vr18hcjdmds8GkJUHN6t3pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725471099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1tyhSHPGeGNPrKi4QSR+hpD0VnX4AnAsJWt+sL5cNOw=;
	b=veOGcoL4TGPCX97tcLERTsm0Fd0BfSTWSvQ0yGfCN8t/aL9jbXLhte5cVF/q7wuLX/9HZw
	+g8F8Z2dNSrSfaCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vfaxAxex;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=veOGcoL4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725471099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1tyhSHPGeGNPrKi4QSR+hpD0VnX4AnAsJWt+sL5cNOw=;
	b=vfaxAxexjHuSZaI8f5HtEYwRLLdJFMnCUN/4Yv8bJ8ryAFFOyRc2C4tc+byKv7UZM0LCo6
	TlGvk2dKDqXbfMXpNdtw1om2LJNgkbsPSWN1EkAx7YWbRvZvOKdX4qTwG45Xl+WmhX0ect
	jqsmA/67vr18hcjdmds8GkJUHN6t3pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725471099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1tyhSHPGeGNPrKi4QSR+hpD0VnX4AnAsJWt+sL5cNOw=;
	b=veOGcoL4TGPCX97tcLERTsm0Fd0BfSTWSvQ0yGfCN8t/aL9jbXLhte5cVF/q7wuLX/9HZw
	+g8F8Z2dNSrSfaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62521139E2;
	Wed,  4 Sep 2024 17:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GkjEF3uZ2GZ6LgAAD6G6ig
	(envelope-from <mfranc@suse.cz>); Wed, 04 Sep 2024 17:31:39 +0000
From: Miroslav Franc <mfranc@suse.cz>
To: linux-s390@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: [PATCH] s390/dasd: fix redundant /proc/dasd* entries removal
Date: Wed, 04 Sep 2024 19:31:39 +0200
Message-ID: <87ttevuxz8.fsf@catherine.suse.cz>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6CB051F7DB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

In case of an early failure in dasd_init, dasd_proc_init is never
called and /proc/dasd* files are never created.  That can happen, for
example, if an incompatible or incorrect argument is provided to the
dasd_mod.dasd= kernel parameter.

However, the attempted removal of /proc/dasd* files causes 8 warnings
and backtraces in this case.  4 on the error path within dasd_init and
4 when the dasd module is unloaded.  Notice the "removing permanent
/proc entry 'devices'" message that is caused by the dasd_proc_exit
function trying to remove /proc/devices instead of /proc/dasd/devices
since dasd_proc_root_entry is NULL and /proc/devices is indeed
permanent.  Example:

------------[ cut here ]------------
removing permanent /proc entry 'devices'
WARNING: CPU: 6 PID: 557 at fs/proc/generic.c:701 remove_proc_entry+0x22e/0x240

CPU: 6 PID: 557 Comm: modprobe Not tainted 6.10.5-1-default #1
openSUSE Tumbleweed f6917bfd6e5a5c7a7e900e0e3b517786fb5c6301
Hardware name: QEMU 8561 QEMU (KVM/Linux)
Krnl PSW : 0704c00180000000 000003fffed0e9f2 (remove_proc_entry+0x232/0x240)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 000003ff00000027 000003ff00000023 0000000000000028 000002f200000000
           000002f3f05bec20 0000037ffecfb7d0 000003ffffdabab0 000003ff7ee4ec72
           000003ff7ee4ec72 0000000000000007 000002f280e22600 000002f280e22688
           000003ffa252cfa0 0000000000010000 000003fffed0e9ee 0000037ffecfba38
Krnl Code: 000003fffed0e9e2: c020004e7017        larl    %r2,000003ffff6dca10
           000003fffed0e9e8: c0e5ffdfad24        brasl   %r14,000003fffe904430
          #000003fffed0e9ee: af000000            mc      0,0
          >000003fffed0e9f2: a7f4ff4c            brc     15,000003fffed0e88a
           000003fffed0e9f6: 0707                bcr     0,%r7
           000003fffed0e9f8: 0707                bcr     0,%r7
           000003fffed0e9fa: 0707                bcr     0,%r7
           000003fffed0e9fc: 0707                bcr     0,%r7
Call Trace:
 [<000003fffed0e9f2>] remove_proc_entry+0x232/0x240
([<000003fffed0e9ee>] remove_proc_entry+0x22e/0x240)
 [<000003ff7ef5a084>] dasd_proc_exit+0x34/0x60 [dasd_mod]
 [<000003ff7ef560c2>] dasd_exit+0x22/0xc0 [dasd_mod]
 [<000003ff7ee5a26e>] dasd_init+0x26e/0x280 [dasd_mod]
 [<000003fffe8ac9d0>] do_one_initcall+0x40/0x220
 [<000003fffe9bc758>] do_init_module+0x78/0x260
 [<000003fffe9bf3a6>] __do_sys_init_module+0x216/0x250
 [<000003ffff37ac9e>] __do_syscall+0x24e/0x2d0
 [<000003ffff38cca8>] system_call+0x70/0x98
Last Breaking-Event-Address:
 [<000003fffef7ea20>] __s390_indirect_jump_r14+0x0/0x10
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------

While the cause is a user failure, the dasd module should handle the
situation more gracefully.  One of the simplest solutions is to make
removal of the /proc/dasd* entries idempotent.

Signed-off-by: Miroslav Franc <mfranc@suse.cz>
---
 drivers/s390/block/dasd_proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 0faaa437d9be..e009875cb308 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -350,6 +350,7 @@ dasd_proc_init(void)
 	remove_proc_entry("devices", dasd_proc_root_entry);
  out_nodevices:
 	remove_proc_entry("dasd", NULL);
+	dasd_proc_root_entry = NULL;
  out_nodasd:
 	return -ENOENT;
 }
@@ -357,7 +358,10 @@ dasd_proc_init(void)
 void
 dasd_proc_exit(void)
 {
-	remove_proc_entry("devices", dasd_proc_root_entry);
-	remove_proc_entry("statistics", dasd_proc_root_entry);
-	remove_proc_entry("dasd", NULL);
+	if (dasd_proc_root_entry != NULL) {
+		remove_proc_entry("devices", dasd_proc_root_entry);
+		remove_proc_entry("statistics", dasd_proc_root_entry);
+		remove_proc_entry("dasd", NULL);
+		dasd_proc_root_entry = NULL;
+	}
 }
-- 
2.45.2

