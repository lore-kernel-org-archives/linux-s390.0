Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81E18EFCD
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963039; cv=none; b=c1XxkimfxAvcoCiCqMLg3oBBstV3i5YI7KL03i1bgcHAZyouyofIpnMXoxt5yxNfzFKDw1Nx0rS0XtbdQoxEzMI+7JO92EpvoM7ZJK9JFEdKrtElpkbuH9HTw44RvuAXiD+MLxrxx8dKCrc8k1U6nUzoGYa9QnIO9Qp0fCKBbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963039; c=relaxed/simple;
	bh=yQgIcAICTK5FSWGbk9Lt7d2+qEYj6jpsnfuNFFZDyvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppW1t3i+WywnkqOvXKYe9pwyylm3YR7oUPxR+CCMkmE9wbZGLG5Oam8nNdhyR+cVxWFo7oJ0Q7ef+IPJPbsgQLOlyhowJ3URVUsPnq9Zvtvl6BKt2jkIP72wrSLyvU+8UhbPDXP7FbfspBUuvuy0nRSxsuH4Ia4SCCZqRtq0VmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrW5H+1w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrW5H+1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725963037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
	b=hrW5H+1wbKRr5+l/WQ2cweyMqgdiT3f/FjBuOPWCWTShjHc0k2r00G/Dr12XplOtvZJdzL
	XyUSAZ57IJ4jNcvRmgX1YHIcsu1sgAonJBqprIR8tYB1EaT8w6AywU77z02aoVoUCXR3LG
	7Ik3+Kqtv/9lUvPPSnyPpv6EyFT5rAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-HiAkDFnvO9yNHBo6uBMODA-1; Tue, 10 Sep 2024 06:10:36 -0400
X-MC-Unique: HiAkDFnvO9yNHBo6uBMODA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso42359165e9.3
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963035; x=1726567835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
        b=NLUZbSLxvhODO7/jFb8Ntvq7Nwvc2hEz3IEmKJDHFmUrgFoMmqq3jfmDCpUZSNf9aH
         UPEU1EDVQT9VOZZrm/BzJN+EBPRZLOPa3aMXAP33CI/TgYYRUiXXIE5nMXLfFuBo2dCv
         EsHR6Fmf3hgDLsi55V5oygzmvCh/oR6yKd43iCSkOpYzCtjaijgA14KVVV2m2FkMEhAP
         4b26bu4Vyc1rE3nE4qz9PTGJT/Vpl5dpG1rRCVsF8Q5Jn50GON04x4VglElnvr7OQ/r2
         aATU5DMy4w0bqGTfl1jUhbCPuqGHAqmwSIqI9t2Rs7d5yVGkLJN7X1Y35fr0G3da3cKk
         6G3g==
X-Forwarded-Encrypted: i=1; AJvYcCW0wGDnFI5t/KYzrPw79GU5zmWfCy8CJvfMAHG0Refny4rcJK6pKbKWiorUqon63ydjZuupYRnkKr3u@vger.kernel.org
X-Gm-Message-State: AOJu0YzroPBj65vJBtvtDMomstmNT8MuNUdRiJEHHLSaAXaPvUSV42SE
	Dct+m2kTLdxJB4OCqZ3gtYgWWbBjomUlIVZmryccaSPsyy7wLUyejEHX9ZcbaCoEuFX1Ej5QZ4u
	3hPEaC0yzAOWvIf7zQsTa2YGWce2harfO1lH5p9DzIiJVBs3DCgWFGxUhAng=
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35477185e9.7.1725963034868;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UJumNEoidGRa50Pqmtdr9Dobsm4P/vGruZsRioKW5XA/TzKoc4apQYmFttnD6MjWJ08qzQ==
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35476865e9.7.1725963034316;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21cdfsm105744195e9.10.2024.09.10.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 03:10:33 -0700 (PDT)
Message-ID: <8a1684ca-755b-4612-afe1-41340b46f2fe@redhat.com>
Date: Tue, 10 Sep 2024 12:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, edumazet@google.com
References: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 04:35, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.

Not blocking this patch, but could you please describe why/how NL is 
less convenient? is possibly just a matter of lack of command line tool 
to operate on NL? yaml to the rescue ;)

Cheers,

Paolo

