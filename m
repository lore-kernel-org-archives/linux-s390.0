Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0A1DED72
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239483; cv=none; b=Cy9nvMosoqqFidJ0YaVSN9if9wgwDhqxi0Xrvvx5pS274TjvjD3OyjBwic281jqI1EhugnxBjTm4zdJZH98MqMNt2QqnkBXknIfn78fM7AJh1w9nuw8Xq59iZRnmdoqCRxPSTm10sFb3YK/Ud2Q270HLNLQnOFK0h9w+nnaWXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239483; c=relaxed/simple;
	bh=9z4E307FEw5yEmX/R4lxvUrMV7D0T547+CC68yqF1tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nR3FJphaqfXYCzrLqPeeUBFXXLlESD9BJL4K9/VYIunqd1x87iaU56bUNhfPLuXL0Rna2ccEQLipHfDJ8BExrfYgkZPsAr4sKjNDA8ZDKX9F8VnXpR/xA6Z/u47YojjXoZ/8gz15s3g3UGJj0zJIOeWIRkV5NQtZY/JJSqPOTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9fDYTfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9fDYTfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736239476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
	b=S9fDYTfwQok1tTQZDF1UWH8e1gByy9gs2ivLwQKJ6ClBM9GS2B6kiXY//MOV/vUqOopUeo
	UFRZh7kkaCqXAKDUEcCjzIOVgfPJvWr/cLAGjohw09Dzb4HuGctZW4Xm3BhUiiGo7rxmAu
	0Tc2N9Mm+sEwDu0vVszvfBMihEZAeqU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-AmOh1DJhPr258u5FrLVIcw-1; Tue, 07 Jan 2025 03:44:35 -0500
X-MC-Unique: AmOh1DJhPr258u5FrLVIcw-1
X-Mimecast-MFC-AGG-ID: AmOh1DJhPr258u5FrLVIcw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6ecd22efbso3015916485a.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239475; x=1736844275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
        b=AxtuCCnHSE/4Suiz1A/5hx7oW0geGl9o1fhrrf0pNNsWdxf9uISLyz+/UzkJtOW6mI
         LgexkKPiSx9duFatyQAxJFoyIxWAZsid3tGXFZ1qFbElK1+/mWnEtVUDWw23QPK0aI6e
         dGbjihdO/Hi/SL65/KAYuSmIvTMiDT1BU8XgR1Q7KJCUip/lm+eoJbiAPm9/7XX/vyeA
         4Aqud0R5QCx03SsJI7NGcOD3jqul8A96tJamAMOmEq3+jtpAxvKVRd7CS4e1RJLGwq9Q
         zSMTjcLrDNTRLgshQA8HLajmbb26Cm+abEpUB75SJoi6xOQgg7ydclMFw/gUi05xJexE
         uU7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQWv1ec3FD/ySo4w7SNpvp+kSo6l8cL1tSI7ZvbEApRhnck0AOtqaLNyW0/cF+zdZ7EBf5UWwGAy6z@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBE2vf88ml25u2jJKXaC+Uvgls5Do+4Nl44L14bQzNIYyZxOD
	87SbY1lJsjLrImLpGXwQEUPsuwz89FP9HuAZthGU2nvp/+qum7lZZ311VEVnpVminRwbICwbAIT
	GDpIvN6XDIBtZq0nC6pDnJf+uWvxocELxQQXRgDC7cp1/xSm6iGtSLbvFBAI=
X-Gm-Gg: ASbGncvkKUFo0saOPQmVQXgSprGHakQIYOe4ouCVql4hy4aysvaP9yI30D4Y0D1qKnx
	NvqXJ79S0/IOVSIC4CpoPQNfvYQ48AvaUdmYr4hc5G2pBoorwyrQYRekiI5srsavtbGUNl3FyRd
	D8KO7PVRttaHsWRjl/FBlEnAfgBlEelrH/mT/4JpM3WRHwHXF8z58/HJFPixrRly9AbBLOnzWKH
	O8xFJJ6b7IqjOvo2Bkmc/GgEuVlzEEQIz+DO+yHcqqiNDvOgcsB/m0QuxurDEzGeyr8nA3gOxlL
	Spj7gg==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357935185a.16.1736239475071;
        Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQCMcAkJhmI/CqAK5HFPejGMDCVtbEjbyNYs7SJgbt11nVHwRNfhnAYo5Ac+BtyoR7P+tihQ==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357932985a.16.1736239474732;
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2e6587sm1573880685a.48.2025.01.07.00.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Message-ID: <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
Date: Tue, 7 Jan 2025 09:44:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/24 5:04 AM, Guangguan Wang wrote:
> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> to the pnetid table and will attach the <pnetid> to net device
> whose name is <ethx>. But When do SMCR by <ethx>, in function
> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> use of the pnetid seems weird. Sometimes it is difficult to know
> the hierarchy of net device what may make it difficult to configure
> the pnetid and to use the pnetid. Looking into the history of
> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> that changes the ndev from the <ethx> to the <ethx>'s base ndev
> when finding pnetid by pnetid table. It seems a mistake.
> 
> This patch changes the ndev back to the <ethx> when finding pnetid
> by pnetid table.
> 
> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

If I read correctly, this will break existing applications using the
lookup schema introduced by the blamed commit - which is not very recent.

Perhaps for a net patch would be better to support both lookup schemas i.e.

	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))

?

Thanks,

Paolo

