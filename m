Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A654F8BC
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlL62emM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKqsc59G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlL62emM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKqsc59G"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55A0521E2D;
	Thu, 11 Jan 2024 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704984862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjZJy3i8CX0Am+U9XzBu7lgLhwU5lo/TMd/QcvTNBcQ=;
	b=wlL62emMaLoX5GCLqlGt3mOyfjKR0YShmk00JGzpcqhDECyf1/dmy2sLRuY8Cx2se99LwF
	tY+gAimpzO8ty9za2JdevvWpIyJ4CSc7ugzxebqa2r4Uv1FJgGbRkEtGWNTYU3Oz1FRx91
	8bwk2IgK6F9GtWiZfviMWfnKWGjbu7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704984862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjZJy3i8CX0Am+U9XzBu7lgLhwU5lo/TMd/QcvTNBcQ=;
	b=hKqsc59GIWRUJMi4V8XuJo9OVBRp664DSPOyYHQr7dm/l4Pk905Z0er/6bJ15Y0jCQyrpx
	HVoNKexkYzqFrWDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704984862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjZJy3i8CX0Am+U9XzBu7lgLhwU5lo/TMd/QcvTNBcQ=;
	b=wlL62emMaLoX5GCLqlGt3mOyfjKR0YShmk00JGzpcqhDECyf1/dmy2sLRuY8Cx2se99LwF
	tY+gAimpzO8ty9za2JdevvWpIyJ4CSc7ugzxebqa2r4Uv1FJgGbRkEtGWNTYU3Oz1FRx91
	8bwk2IgK6F9GtWiZfviMWfnKWGjbu7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704984862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjZJy3i8CX0Am+U9XzBu7lgLhwU5lo/TMd/QcvTNBcQ=;
	b=hKqsc59GIWRUJMi4V8XuJo9OVBRp664DSPOyYHQr7dm/l4Pk905Z0er/6bJ15Y0jCQyrpx
	HVoNKexkYzqFrWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BECF132CF;
	Thu, 11 Jan 2024 14:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRJEEh4BoGU5RAAAD6G6ig
	(envelope-from <mfranc@suse.cz>); Thu, 11 Jan 2024 14:54:22 +0000
From: Miroslav Franc <mfranc@suse.cz>
To: Jan =?utf-8?Q?H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
 linux-s390@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] s390/dasd: fix double module refcount decrement
In-Reply-To: <a69fb463-384b-4bf1-8cc7-0d442ec72b2c@linux.ibm.com> ("Jan
	=?utf-8?Q?H=C3=B6ppner=22's?= message of "Thu, 11 Jan 2024 13:56:01 +0100")
References: <a69fb463-384b-4bf1-8cc7-0d442ec72b2c@linux.ibm.com>
Date: Thu, 11 Jan 2024 15:54:22 +0100
Message-ID: <87le8vyl7l.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 INVALID_MSGID(1.70)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.10
X-Spam-Flag: NO

Jan H=C3=B6ppner <hoeppner@linux.ibm.com> writes:

> On 10/01/2024 17:01, Miroslav Franc wrote:
>> Once the discipline is associated with the device, deleting the device
>> takes care of decrementing the module's refcount.  Doing it manually on
>> this error path causes refcount to artificially decrease on each error
>> while it should just stay the same.
>>=20
>> Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
>> Signed-off-by: Miroslav Franc <mfranc@suse.cz>
>> ---
>>  drivers/s390/block/dasd.c | 2 --
>>  1 file changed, 2 deletions(-)
>>=20
>> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
>> index 833cfab7d877..739da1c2b71f 100644
>> --- a/drivers/s390/block/dasd.c
>> +++ b/drivers/s390/block/dasd.c
>> @@ -3546,8 +3546,6 @@ int dasd_generic_set_online(struct ccw_device *cde=
v,
>>  	if (rc) {
>>  		pr_warn("%s Setting the DASD online with discipline %s failed with rc=
=3D%i\n",
>>  			dev_name(&cdev->dev), discipline->name, rc);
>> -		module_put(discipline->owner);
>> -		module_put(base_discipline->owner);
>
> Good catch. I think there is one more line above this part that should
> also be removed:
>
> if (!try_module_get(discipline->owner)) {
>         module_put(base_discipline->owner); <---
>         dasd_delete_device(device);
>         return -EINVAL;
> }

Oh, I was under impression that the following line is necessary for
dasd_delete_device to work that way.

device->base_discipline =3D base_discipline;

I could move it before the if statement before removing module_put from
it.  Does it make sense?

>
> Can you add it to the patch? Thanks!
>
>>  		dasd_delete_device(device);
>>  		return rc;
>>  	}
>>=20

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
---
 drivers/s390/block/dasd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 833cfab7d877..8e453454c271 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3533,12 +3533,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline =3D base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline =3D base_discipline;
 	device->discipline =3D discipline;
=20
 	/* check_device will allocate block device if necessary */
@@ -3546,8 +3545,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		pr_warn("%s Setting the DASD online with discipline %s failed with rc=3D=
%i\n",
 			dev_name(&cdev->dev), discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
