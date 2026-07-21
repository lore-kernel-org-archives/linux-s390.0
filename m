Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5F3C2790
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649761; cv=none; b=qGPf106pItGGfmuA535Qsbhmu8f+52jnlShsO2oHWW4rvLqVtBEYyXPaifllD5sOHDXG4W3P5fg1MQIdT2NzbTNkHDPQIPHoGRMLrsCpXs22aC3oiwU7l3dRiGJT7/8o/jk1RitTuqcRb7FMd6iDWX+Tp9+TW/JgQ7SnnYu9NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649761; c=relaxed/simple;
	bh=QbecFF3Bj+oUuUqMeYFOnB+fOLZZQA5qxTNfzeNSYs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HG/PsDovnpWpC8wdHq8jJAAXyk4FDlmebAU07L1WHoCZspQSapLhDT5VDviBACcyR5o0hq03lfqQSPNrE17UuXQMe9v1IjOUUtYyVIfzM/QQEuLaHkrPchpmMLYfJ2YqINypcR1JEFTMRtb1pc+Pg+egMlsmuDXeP7mL4KIuuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSeWxLNh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVVx6lJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSeWxLNh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVVx6lJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784649757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6x6QNzb/HvmxRGGOWk16eMCJgHy8fOxO3QEXxqvBLQ=;
	b=iSeWxLNhectrToWd4lKm5S69c99eJLtpPXk6ynYwkYzSQYyMS23EA/F5Be9iUxoB5XkckW
	/56rn85eC9sef6pBZkBIN7hXt48IYuHPa7aO6Ii4hCPHaXFDFPD1GjQ2eY71Tayguob5hL
	lwy4dJmDkaHZyLWawPfrvMZvUefmEjA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-DVYJsk6oOmCXaiTK2ifgAQ-1; Tue, 21 Jul 2026 12:02:36 -0400
X-MC-Unique: DVYJsk6oOmCXaiTK2ifgAQ-1
X-Mimecast-MFC-AGG-ID: DVYJsk6oOmCXaiTK2ifgAQ_1784649755
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f81362fb1so534250f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784649755; x=1785254555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6x6QNzb/HvmxRGGOWk16eMCJgHy8fOxO3QEXxqvBLQ=;
        b=QVVx6lJdH8tJyXdEWIse8Lol2ivbUulabJWzmHZCqtbzhCnpSUrHK0N92efqGyZ88E
         Ksj76C4q9z39fEui0zWbPsaBLwHLRGs7VRTEUuYTDamCFWJ/2g3bTA+9IMwuQe8wQJxA
         YZyE4nRBK9fnNVRTzxOzoAHmhjFoSSO5Hq511pPhwrG2A+0YQG2LyyhKwN/Kj/YvjmSt
         4WGGhqPIw/2ob/E6F4hrXd7xVFqokjW/NaU+3mu06/qU9bILxNrT5v1U0xY7K37cAhxv
         1zdLBV5O36sqt0JLGt4yh/aeovWq8bAYMwkY7Vkx5MsHTATvg4DErRm4vDLLtoTtrvgJ
         Yl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649755; x=1785254555;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6x6QNzb/HvmxRGGOWk16eMCJgHy8fOxO3QEXxqvBLQ=;
        b=qpdz82uAaqAZ+Z4ZqUKfCMurNG6DuiHxsULhRsj/67bCbcuKogk9azstZEae2RkCcx
         jH/6GIqDTj1LGolDHajuu3LcVaUWKcuV3iDcLaJ0r26WGb+ZNkdoC8KrKm7OzuWv1JUH
         FGmXbKVXmkvLkv7yNDi2diKiJwhfUoT1VFiJtjc1klQruKYGL6ODZROBIVyFtReLpHTx
         v8oX/xWUUM9h0BadvV5/+wqvAuWuFO6XRvA3VFan1skrvcp9Fr5tDZzKfe2qxehkDZ+f
         kbaGraMc5WD/klR6FmUDiDLikkWRiyfJ7X+B2kIP9w0eSUcXOSM6XflOwM2NSwF2mebv
         eYag==
X-Forwarded-Encrypted: i=1; AHgh+Rqksp571Jy/ElcyZvr+iskKFzHeGyInrrc6wniqybFfr7dbolDhgur7l8y12S2JFMXCaqS9W9k53UgT@vger.kernel.org
X-Gm-Message-State: AOJu0YzJV7aa7nsToPxXHXPoaVu8u5lJ/fsDTimz4U3H6Klwc4Hg8mbE
	4t3QPFqpMQ27Hh9JgQwhOMnsXyOSUwgozFlJQLpTJMYZqpNDRddRb9CNrpEa2eosFwd0o7tnbf0
	x42JSn2vqD6k2JLodCbWWqdKSI/jsERhyISRnxvestyumyxb/QWwfxd9ihfetPIY=
X-Gm-Gg: AfdE7cmwJJT5lJ+5yY++NvApYPi0owRxqbnHyHRNrKBoXotfDbLSjFQt6ic90W9gD+a
	o6Ze9z1qtutVX6sWCrXM5cuxBSfeM9lr6L5IJvFRljuDnNHjuN86U6ZIF0bzrTppKQGaxKDc5to
	Z9gMY1Ud9XqYSv8BZ1TgduzhnPm9cSriDs5qLQ/iLehjRdghx2CnAR//AONjb9LUsMijV+jlBww
	2DDhrtHPGq6j3NltZ1qOKk7zes0RODtVxf7kHmPhEqdkiDbgqOAmYWyDesx8GX6/0o8anNjVyvm
	pgbRrj7QEMKIzIXB6b0o8Vc2RGJahU+Qf1qEs9gzM736T4+k+wIUuWS8AD67T0Mwugzdm2xuzvG
	bgYPeE8LF2Nayqe9Lr669xAYc834hT4Abcm6ryOyXboLcVc2MT0KOBbSawrfVV2i7cmN2rco8iy
	Cizg==
X-Received: by 2002:a05:600c:1549:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-4954a3d08c0mr211720355e9.5.1784649754891;
        Tue, 21 Jul 2026 09:02:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-4954a3d08c0mr211719605e9.5.1784649754333;
        Tue, 21 Jul 2026 09:02:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfed7sm87017835e9.11.2026.07.21.09.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:02:26 -0700 (PDT)
Message-ID: <593ad84c-279d-4d3e-8137-f48188c45c8e@redhat.com>
Date: Tue, 21 Jul 2026 18:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
To: Alexandra Winter <wintera@linux.ibm.com>,
 Hidayath Khan <hidayath@linux.ibm.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, twinkler@linux.ibm.com,
 heiko.carstens@de.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
 <fff72695-88b5-4ba5-b1f4-f70a2b02ed1b@linux.ibm.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <fff72695-88b5-4ba5-b1f4-f70a2b02ed1b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 3:54 PM, Alexandra Winter wrote:
> On 09.07.26 21:17, Hidayath Khan wrote:
>> afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
>> If the allocation fails, nsk is NULL.
>>
>> The connection-refused path is entered when the listen state check
>> fails, the accept backlog is full, or nsk is NULL. The code
>> unconditionally calls iucv_sock_kill(nsk) in that path.
>>
>> iucv_sock_kill() does not accept a NULL socket pointer and immediately
>> dereferences sk via sock_flag(sk, SOCK_ZAPPED). When nsk is NULL,
>> calling iucv_sock_kill(nsk) results in a NULL pointer dereference.
>>
>> Only call iucv_sock_kill() when a child socket was successfully
>> allocated.
>>
>> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
>> ---
>>  net/iucv/af_iucv.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index fed240b453bd..f5b1ec44b6ae 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>>  		afiucv_swap_src_dest(skb);
>>  		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
>>  		err = dev_queue_xmit(skb);
>> -		iucv_sock_kill(nsk);
>> +		if (nsk)
>> +			iucv_sock_kill(nsk);
>>  		bh_unlock_sock(sk);
>>  		goto out;
>>  	}
>>
>> base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37
> 
> 
> Gentle ping to netdev maintainers:
> Did this one get lost in the overflow?
> It is all green in patchwork. Is there something you need us to do?
> Should we re-send it?
> I don't see this as urgent or especially dangerous.
It's still alive in PW. Our backlog is unusually huge due to an
unfortunate sequence of season holidays and conferences, but hopefully
it should get back to normality someday in the future :)

/P

