Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748284B5DE
	for <linux-s390@vger.kernel.org>; Wed, 10 Jan 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJtRfrUC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXZCKpc2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crNIgwTp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FoKY6K8e"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF5EA21E1B;
	Wed, 10 Jan 2024 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704902523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4995F0AdHJpcW/yRHg0Sjz3xkX+EArRev5JR72wjEk=;
	b=gJtRfrUCX3oSWfeSTOyhIjNWcYJNNFT84a0o3/BlAgZkOrTPGAXytrEmfJnkxAiKNgBDdF
	9cGhRxOdWBYT9ovSFZwVerSQgtdxbVVkp2v0cfg1C0zFhGN4POCftklnCkfdniHI+muY76
	XpADuCh4YHzcwOmKdbT1/hcoDIZw99U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704902523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4995F0AdHJpcW/yRHg0Sjz3xkX+EArRev5JR72wjEk=;
	b=eXZCKpc2+2h1WCH/MXnSDbD1Y3XqRddUxJYhp3Xev++d4G400Mb6Ynq4ZzyCOkG233RNZI
	2BCNvcjP3IloFKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704902521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4995F0AdHJpcW/yRHg0Sjz3xkX+EArRev5JR72wjEk=;
	b=crNIgwTpOWjvc4ln6tn8kzE0i7pnLYMJaiO0E3RinEEa9NyfcRMdXGYUPqBMyGE7nyo5cm
	r8RODEQcmK7vCLOqc+w0NQth1fhOjB8zv7oRENmmsSK0MwRIVlsLNVc7csmnRxuPQ9wtFW
	dO5FgYZ6QYt5lpmlmW649tGMs+NpEOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704902521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4995F0AdHJpcW/yRHg0Sjz3xkX+EArRev5JR72wjEk=;
	b=FoKY6K8egnSUBl4w6BsQxu+k39/eY5/YVUfeXQKTG1Rd4oFv7+rF43SztwDe/1s2Ulgqf2
	h0GhkFb6DI8DhdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A60631398A;
	Wed, 10 Jan 2024 16:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D2dGKHm/nmW0KAAAD6G6ig
	(envelope-from <mfranc@suse.cz>); Wed, 10 Jan 2024 16:02:01 +0000
From: Miroslav Franc <mfranc@suse.cz>
To: linux-s390@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: [PATCH] s390/dasd: fix double module refcount decrement
Date: Wed, 10 Jan 2024 17:01:57 +0100
Message-ID: <871qap9nyi.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 INVALID_MSGID(1.70)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[23.67%]
X-Spam-Flag: NO

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
---
 drivers/s390/block/dasd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 833cfab7d877..739da1c2b71f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3546,8 +3546,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
 			dev_name(&cdev->dev), discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
