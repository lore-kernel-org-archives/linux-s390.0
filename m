Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAD3AAF40
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941051; cv=none; b=Eyk2DzRFD/0g7GN4Z0gxim6pfhbnW2hg/T7kvU1m5quM3/BSq9MkpGR14YqMPg195Vk+w27OuseJF5GazwFJ9CO8B5ffHywaF58wx/dJsYNTgmO7swcSV63aBY/cu79REMUnwHGzRQfN9hxpbvLuo9S0fGdMApwWE1+IcZkgWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941051; c=relaxed/simple;
	bh=e1+Lb/NG+mk3Ilrk3d4Lqqcpc5Zw8k7/MCjnzOdByLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuLOVPTXXsaPLo1Z0BCTey2waauGugAifAjluSUuM4omGAlDUj3D1060s43dhHjxiDvDZ5NwT/gnTCABbd9yS7DJ2qI6F2A7h6K+NC9KfXJuRfHzqpF/2GAxpQBYDNgp2ai8T19rnjUuYJl7no+LEUXvYM7lK348f9D2lIXxm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VryFZB83; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k9R4+inj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VryFZB83";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k9R4+inj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788941048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
	b=VryFZB83+cpgeoa/pX5Gm+7Yba3EBVztfJmoRYkyDFhCB5o7mOiYHGjDlBNMF1fpAW0+79
	z+iPvG56AUuaWS8qAJv6LaCKAuA1WHAFf0TW1G3AJ/baQlIhFupr1v8sRCnkQYjFfEJ0jP
	9J50egJKA1e3Yq9e5VCTl+K69a6OTQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-XEO5POn0N6a59GdSwfAdVg-1; Wed, 09 Sep 2026 04:04:05 -0400
X-MC-Unique: XEO5POn0N6a59GdSwfAdVg-1
X-Mimecast-MFC-AGG-ID: XEO5POn0N6a59GdSwfAdVg_1788941044
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f41ca436so4906432f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788941044; x=1789545844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
        b=k9R4+injsc/zbqg0EA2TiH1ju0+WWPJJsyndH2z63bbD4wmNJrPQhm6Y7SKH8as9cy
         oyackBYiVfOR+IepwIF4tDGSDhZLLvYyJy0r2yKUxzfHTGv8bmYCfWAwlE1VMOpvQZOO
         USkP+l87T7hRinb+ajFFhywlZ41IQOhCD59lDeUuqJV66j5kDedOlK6o+UU2/yzj98V4
         ly6q4OXi6guTv1RiVmhgpgVrY8+sfP1DMfQ1ixrwA3HEOl5GfwPmFOrz3+qHoBxy5HPf
         HGwWMydYDnoNGQPmo8MA/DRBv96x0UWoQseLf1DG5W5W8d914yFO1spKGbTgaLJCfYkG
         0nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941044; x=1789545844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
        b=ABotHU8eqsmGYdm3CEVREfCw6Y3B2Dl6rAkTi1mhblJsNzy8CkzUYdy50YIYjO3Q9/
         krGcheHVIL73KQBkyGvBr9yEYA6r93vsDPXF143twVDAv5P7SXy6n48dH9Cw+p+Yg2du
         gEqgqKHsCpz5EVhG7z4hdxorYQP97oXIiiUjGZuTXGcEBaWUz4vag+Eo0AyNjDtTiErO
         6viXRhT+egfdcOtv33RsVKeshgW3H5EtSw+l39eyViu/f5W9Rv500+SzuE89mPSeEeIM
         X8G40Wxi9/S+/fchDwSR9id7FclKtxogAB/ub0TQZliWbf3CWbqP7aTFjSYFhWQQ1Av/
         rLKw==
X-Forwarded-Encrypted: i=1; AKwUvBz2N9DqfGoAFNQGzudG+6Rven1qpgjnwZrihXwYX46RDNeSJAdlc2aS83qDo2gnBAFlfu8rD77j8owD@vger.kernel.org
X-Gm-Message-State: AFuF++ncN1RjuBVg/Z4bkZ0kthsn0IlDGNL6H7e1vVO3QBcFOFI4RVpP
	UrWhV895q8eSOErxWEaw4Nccwn7FunPUP5bXZofAf7KeIl3cw7xNhtT3C2iAhTdCh8E5PYqHoa/
	hlS8rCQwW8BiOAvzJ/j/fRxJOMqnjTgEN7PpcnCxMW8jdWgV2N7LK29PM1BsNPj/UsMrnvfw=
X-Gm-Gg: AYBFou35eILOL+RV0AhUUHMtqS9VAtKp1lIa9gLlG07sBna60Gy7v5skL+qLrjq4Qx4
	wUWFaxOTIJXw8woKua3cjL+0VD1gSza8KyBzjucE8JkyOJewnr7E4qRcZTzVTpORRPrHEQeoyjL
	zindaZDvIbc+Y6S4jhntvR24J8Rdtn9QjkdiFUh03Bo46OnxWPk1K7TPNm3ZEiO+Yzxgyk+PpGT
	BZRfQMwN4qnF0XtxLU+SZJz87ViJAf570+vF90nVxv9EHvp4OrTxQAfm8fEhcM86GGA6TDY/E9Y
	CyRSb12WH0Y3PNpUZnJ49zzNcGmYohQfw5eCR6A9fOdHxAuoakuV42GJYY/3sq7TDznvurYDl7Y
	Uuok9B9gH9ZdtaPLCKUu2ltoSQzEcCaO3l2MEElk/Pp5JfwDSf/rcqkW1abvZ4WM4rCMQMV2nbQ
	==
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr360364085e9.6.1788941044346;
        Wed, 09 Sep 2026 01:04:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr360363415e9.6.1788941043923;
        Wed, 09 Sep 2026 01:04:03 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm89320615e9.4.2026.09.09.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:04:03 -0700 (PDT)
Message-ID: <d447c4e8-9f68-41fe-9598-68a35f48057e@redhat.com>
Date: Wed, 9 Sep 2026 10:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
To: Alexandra Winter <wintera@linux.ibm.com>, netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
 <178887153533.219967.1817289806507440884@kernel.org>
 <a5ffb5d2-4509-4e73-af0d-aad4b1cc9412@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a5ffb5d2-4509-4e73-af0d-aad4b1cc9412@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/26 7:04 PM, Alexandra Winter wrote:
> On 08.09.26 14:45, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> - [Medium] The patch fixes an observable lockdep "inconsistent lock
>>   state" splat produced by the plain spin_lock(&dibs->lock) in…
>>
>> --
>>
>> Here is the report.
>>
>> dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
>>
>> This converts the plain spin_lock()/spin_unlock() around the
>> dibs->subs[]->ops->handle_irq() call in dibs_lo_move_data() to
>> spin_lock_irqsave()/spin_unlock_irqrestore(), because the same lock is
>> also taken from hardirq context in ism_handle_irq().  The commit message
>> notes this is not a real deadlock since dibs_lo devices have no interrupt
>> context.
>>
>>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>>> index 649e4e375be33..44a2e74c2efcb 100644
>>> --- a/drivers/dibs/dibs_loopback.c
>>> +++ b/drivers/dibs/dibs_loopback.c
>>
>> [ ... ]
>>
>>> @@ -267,12 +268,12 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
>>>  	if (!sf)
>>>  		return 0;
>>>  
>>> -	spin_lock(&dibs->lock);
>>> +	spin_lock_irqsave(&dibs->lock, flags);
>>>  	client_id = dibs->dmb_clientid_arr[sba_idx];
>>>  	s_mask = ror16(0x1000, idx);
>>>  	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
>>>  		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>>> -	spin_unlock(&dibs->lock);
>>> +	spin_unlock_irqrestore(&dibs->lock, flags);
>>
>> [Severity: Medium]
>> Should this carry a Fixes: tag?  The lockdep splat quoted in the commit
>> message is reproducible on shipped kernels, and git blame attributes the
>> converted spin_lock()/spin_unlock() pair in dibs_lo_move_data() to:
>>
>> cc21191b584c6f ("dibs: Move data path to dibs layer")
>>
>> The hardirq-side acquisition of the same lock is in ism_handle_irq()
>> (drivers/s390/net/ism_drv.c):
>>
>> 	spin_lock(&dibs->lock);
>>
>> which matches the {IN-HARDIRQ-W} registration in the report, so the
>> warning can be hit by ordinary SMC traffic through
>> smc_close_active()->smcd_cdc_msg_send()->smcd_tx_ism_write()->dibs_lo_move_data()
>> on a lockdep-enabled kernel.
>>
>> The splat also ends with "INFO: lockdep is turned off", so further lock
>> checking is lost for the rest of that boot on affected kernels.
>>
>> Would adding the following help backporters and stable tooling identify
>> which trees need this change?
>>
>> Fixes: cc21191b584c6f ("dibs: Move data path to dibs layer")
>>
> 
> 
> As mentioned in the commit message the paths reported by lockdep belong to two
> different device types (dibs-lo and ism). So not a real deadlock.
> So unless lockdep-warnings by themselves warrant a Fixes-tag (?), I think net-next is correct here.
> 
> Paolo applied this already to net-next.
> For the records: Sahiko identified the right patch to blame.
The current guidance is no fixes tag for net-next patches address old
'issues'. Since this is a false positive, I deemed it as a 'non issue',
hence I agreed with the net-next target (and thus no fixes tag).

/P

