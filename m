Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E23AEF51
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753995; cv=none; b=Os6/gTYRvRm/zTPVQZzyRWRObe8ofEQKhO/HefRTPbYjCHnPIoD7K5vBualO1DSKvU1eDcrsQxwOSfn0DR3Qxg50EvwGpFoEUj6F5vwGMCKnSnvzk08cKfmFPfrvvmUp6XKz5qIfT/EmLwnoPRsHGtVsxnFFnx3neU+tWEo+BE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753995; c=relaxed/simple;
	bh=0IKmOUzoumogJGoyd4uqy+VcQGNDmcN+WpyYRRIEP7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJOL6iW8DvGk/oX0Rl9vPORWVEaTlszMh5pCLhdW8kUbXbNpo+AjZhWOZXOrBrNLHAgTRQ8vScBS/P0pUakXmSdPmQOi+kkcxio2QlasF30/mPnxfUHoF/fneLYaNmOMTwHTpFqW6GHqKPK+Y+PNA2XEczUf/0M2lNTiZoQMYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJDr6VoE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEnEIi0b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJDr6VoE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEnEIi0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778753993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
	b=UJDr6VoEIqYcvbfBwlSWQtJ/+UsyApMbeOcS0SZe3z87pYkV2/fOut5gEi3shfU9151y13
	03dk/hO0Z1uQvseKw0hvK5aDbgu490LcFT8BcsXDn5Qwbos+jKQmLBSOW+7vC4zqwHXD2y
	AuJ3dSXHSP8O8kaEpCnlN0W9mGA3Ky0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-LaXaHsnhNFuvEjV9vXN80w-1; Thu, 14 May 2026 06:19:50 -0400
X-MC-Unique: LaXaHsnhNFuvEjV9vXN80w-1
X-Mimecast-MFC-AGG-ID: LaXaHsnhNFuvEjV9vXN80w_1778753989
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a69f565so6988096f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778753989; x=1779358789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=QEnEIi0bXeEekfIT4LaQXPEyyWxKR/fM3yitOQvv6rbkM31EKL/vl0CMih+c11ZMQn
         MuYjbdJp8zklxo/ITCoZugDu9suHUE0LPVaGFdDonMJm3Y7CDowfmas1n8/y44WdGDGy
         jdTf8DVZOJ94hBHayPqbCA+YJc+wh8M2M8WlSlwkIQBAXPemBQXX62bAGaSQFV8SuCxe
         5TZgXcc6mNnEGFun0kpxbQ7vNmTS1iVDTN+yibj+BHPczdCUg9B+otRt/elpKp8Z9LL8
         /E1jX9BMZfJi/MCUCe4jALCppaoS0vAVi2LsV+Acu21ryxw4Rp6PbMHNcqPDtdFpiQmV
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753989; x=1779358789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=ggqOI94CdHiyxquRrzYYejjIX8hLOUkX4Yy1R1BdHrN+pfx0+lOkrAupa6MA5U45QU
         0UnOeBYZkciLXp3EbdC5YrXpZeliwIdcLRhoEAbz3VdIVikQHimPs0H3RCvbM1mPxrKN
         /O8tXUTdpXgHdNoLtfRle2+iyIVRWvVrQxQJhNfchp79TBso44lV9Cw3HW2zbeq1Gmej
         Juo0iXTYDtfvUzcwmm+T2jHCRy46JaLrom4+1U4J4aY2z3NCwEnSjjwttra1CD1bDhc0
         Zn2SdcgbxtAVKGJSMcS9S+HspfFvqkZkdZM5T8x+i0J/VKHSsrlKtouDd1MBl5Wkcu21
         jzxg==
X-Forwarded-Encrypted: i=1; AFNElJ+1GUPfBWWD5AwMvWmC0Eifvuh/zlRKXKuXWRDAm2WreAqZBygTcTksFEtw8D9Jb+T8RPic7vTzS3o4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzby/N3E6eH9Dt7T5Jo24EMEaGl9yozz5gBvvDUr5YwGxiNC4TS
	1TvMJz7agYeb1TVw0wQt4wPln5nxCKLrJI3IUu4aPoia5ll9QcMbQRsRQ10Mumzmh3mcsk1T52I
	wx9dKDw00Y8esJH1cXaHAeMIom/UK2SLOqo+VM/120g16ycvJ+a5T3pD7EbArUDw=
X-Gm-Gg: Acq92OEtdrJU2LuvEBOeJfOwGFtOu4LkS3OO4hpSZ1NVRGmIXQP81eTHtLqvbe232iy
	zs0uwxxufZ0D3FlcJx2/KPEJosKBuL4KzxyIL4nAs1eg1bCPC0SdYo1hySIcXubAYnvUPAQlGTN
	4IrCcVjzUkydUtR07GUEY6fKSKYUYOSCOeBuJaURovr37EszOQVQZtyVQs7rTatDsic9dGW8W9o
	2Q6lvOBlidRmtKjtitJc/irEx/uQNaw+ACUzwMGCsUS+UpgbzLgjDgP8kjShwEyfoXBYwUtGWO2
	PQ6cNGZ67mNkLE+irB07X/Zae4ZqYcpW1yRHZxkCI3YTrZI6MEy6cR4l7mptsRkwMB4Vw9Pb+4I
	sfL78/IbEa9pCUgdKWe7v1sYb2EFrutGmQWr59MrVfwSnh1Fgva7W3gY=
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11294185e9.10.1778753988930;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11293815e9.10.1778753988485;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6276741sm26923115e9.0.2026.05.14.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Message-ID: <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
Date: Thu, 14 May 2026 12:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
References: <20260511062138.2839584-1-xmei5@asu.edu>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511062138.2839584-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 8:21 AM, Xiang Mei wrote:
> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> populates V2 entries starting at index 1, so when no V1 device is
> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
> NULL and ism_chid[0] == 0.
> 
> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> the array starting from index 0 using the CHID alone. A malicious
> peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
> the empty slot, ini->ism_selected becomes 0, and the subsequent
> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> offsetof(struct smcd_dev, lgr_lock) == 0x68:
> 
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>   Write of size 4 at addr 0000000000000068 by task exploit/144
>   Call Trace:
>    _raw_spin_lock_bh
>    smc_conn_create (net/smc/smc_core.c:1997)
>    __smc_connect (net/smc/af_smc.c:1447)
>    smc_connect (net/smc/af_smc.c:1720)
>    __sys_connect
>    __x64_sys_connect
>    do_syscall_64
> 
> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> 
> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 185dbed7de5d..12ea3b6dbc64 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
>  	int i;
>  
>  	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
> -		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
> +		if (ini->ism_dev[i] &&
> +		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>  			ini->ism_selected = i;
>  			return 0;
>  		}

Patch LGTM, thanks!

@smc maintainers, please note that sashiko reviews:

https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu

pointed to another pre-existing issue in this area you may want to address.

/P

