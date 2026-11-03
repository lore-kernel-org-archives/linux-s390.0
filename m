Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701332;
	b=EO6Q4iJLoXGy6f64CnLJ2WdaZDJT//cW1Vek32QgCNtkE826Qf2ss4u77QwxxIArrp0f
	 gxByorQFjaVZ1HoqY4SYB7IQnEOi+wdjfqq9MmB2aDNpmawODnktmcEbd9g2SCQ4+OHEZ
	 mSF8qev+DRpgm2e3AAXmTSul4NJq7fymWqgb7PH5Ty2YviE84kBCqezC9a36z+pyar72X
	 E3qgwPsj8tsR/g96n4ESbvSGCMPNreEoG9CxcKzIfzXnm8PaJINowcfr4uI2a761f1ubp
	 DAsFEoYubtR6+oywQOWZDAGwP2ML6PrcGUziPDBlTNPOGXPSzer5rExuqQUrvx4JtLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701332;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
	b=snUlIzDySChpIejJG9oVXrydu6Jao2v/gTHRf7Rlv3LfvcD+3zzWm4U3ybOexD7slKbJ
	 zmO3dHYWx7A5si4/oMPXpjOiBS51oTR6HONGtIu/JSM3GBdOQseD/0BIg3MIN046c9duN
	 n5EvtP8/ohraGIWD+7SfEOSJeJFZRwsjoZ+lFb8FTwmWTAecu9hI/rlsmHm3hb5dyPtmi
	 Lv+71RKimbdTKjjqwTsagJQ47GTDVF03VXQqV5jMLVJ1lpov1t92FdpNwb1Ytd1gwBQWj
	 2i7WYCgZ41FG0EmiEnKbMCdSpCKpqL0MruGpSKcXqNN+Qvh23smIoskfcZSZ28CkqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UM1TOyql;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jYIQepxw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834A606EE8F
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 10:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7834A606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UM1TOyql;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jYIQepxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793701325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
	b=UM1TOyqlocBaUTmEXF41uKr1iZWdgdewvuH7z3ARWlnjM6T6yaOjzqeK5tMA3Ib3NDzVzx
	eR6T7nuyxBqr1Oo9rNtfd9uoWoci4CHQq85MUmrrsDLhEk6oIHQL2C3i0ZeBUELJ5/5Xkl
	b9vbwgOP+W/JYZoqFD/6tvTQdD/FQps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-DSvkrm_0PIWt0uNLXxFS0A-1; Tue, 03 Nov 2026 05:22:04 -0500
X-MC-Unique: DSvkrm_0PIWt0uNLXxFS0A-1
X-Mimecast-MFC-AGG-ID: DSvkrm_0PIWt0uNLXxFS0A_1793701323
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso14674775e9.3
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 02:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793701323; x=1794306123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
        b=jYIQepxw5jpnE/O/Q+sT96141cHnoCYT7ktbI905uuCcQiuHZvhQz9xQI5Q6XLYLWk
         ydgMp9p2bhDlP1OyE5F6q1FBjIakzIsFJOI5KLWlE4205bkD1SnjkgYWdj/e4zT5bWUK
         y57Zl+kTN8DsWMdfW54S4i/s1ix6OJCYsoEqezWZvoaKpdTcIwVNAKZwz7yYUhnbD7oX
         YvbrYFXulXIrz1+oD9xV15ZQ3Txp4/0g7HAetCE4y17op4DxJbTtXkRp1c0wpTADOwfH
         LLvfbxM35+I85+l6sUeZbr2GiJUs4PcYip0u2feXEbBCQUZSdBI9fSeCEHBlwfZi7CVn
         7UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701323; x=1794306123;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
        b=lMPa6ZvBLVWpochwOT0+zlJq55b0CPx3N1oKKEkT0F1UOZEepDR3LER3Ktybcbugsr
         SlN0o1JEm70txynSRX+WU17fbvC/tWwHiTyhpiX+rhTwNB7lyeq1E632ezsxkigfTX76
         tXCIu0xo5h/h0opob+Hvi0hx9uoMPtOu+I0ZvN2Ctxz3W3ub+7LjKUz7MeVAPn+36VVq
         A/ApqAqeUaGiNJKtHKdA13orYV0hwriiDPCbxKEGOr4DYux1iobrWi4BqWTPwDGqqOub
         r77FuV+Et1ra607X5meWkWuaa189vpeb5aBFM6Wbp0tfd+VX/3JwfoEFPJHvM8/o/McJ
         Ze2w==
X-Forwarded-Encrypted: i=1; AKwUvBzgiDd8N66MDkjZBty0ud/N9kyX2Gi9SBerVzzOfuxiYp1b18aeaRw0jHycgRcC1FpiURM9oIpJRObg@vger.kernel.org
X-Gm-Message-State: APuU4Z/hjrTTT0u/j3sFHd0YLW/peoU+YPtTUB7ieSE3Wx5QAWzps0ef
	JbpmwF3ZycJ/LDLgtufDVJioJhVTG7QxR69x62FXQs/xm6iyh9bR409On9LeiRoddw36nV9C2C0
	EJk3u/NFSX1dlG4/6BXzsLRGhuNSMHHfnbzNkaPt9F1agAucVofYdynkGMaHXgBQ=
X-Gm-Gg: AYBFou2M/LnE8Gc0TwwGF4AZtjOkBqRCJzY4wT26IAPVWoHEx/0owycoXNUP27rhIs9
	gNmFEXl4KlHREiVOQ9ktfbknbzwGmm42kwfhnHWKI+pbkY643vmk5swtUAfDjAJjyUqLA9x6KR4
	IizRzAeQIXUoV3QUr+ecaKnhz8r0qkcU/b6pX1sIPF0FrdAJTOXnqMQPZX1YjcW+3mAjrThoaUA
	giE3SCG1MZxULl2LgSpWD+A/yke3KsvIoskUBfdkmWZgTzcjvv7/sk+3s7WSfB2WQ+t4n1WO4ke
	Y2eyrG4JK6PwZPbgc2wl9BKpSo1ys9Q5AIpXdT4c9R2Vc/O6JxGsMyVnzCXl+WPCPSNPGAW+/Op
	jRFiBUPfgcqvAMpV/6IFFOrQldShQVTc1l73Ij8s1oUByAoWiETqjLwwGvLLbxQNhj4/bGAWVTP
	FQEhFDh2anUUBzDOoDvkZGWWfBzwSfVfj2BqTbDl8Qi3g=
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr59717635e9.23.1793701323093;
        Tue, 03 Nov 2026 02:22:03 -0800 (PST)
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr59717075e9.23.1793701322587;
        Tue, 03 Nov 2026 02:22:02 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm293753565e9.0.2026.11.03.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:22:01 -0800 (PST)
Message-ID: <fc454b46-b66c-4a16-aa1c-3ea0c2e91d15@redhat.com>
Date: Tue, 3 Nov 2026 11:22:00 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 4/4] net/smc: bound the link failover cursor
 advance to the send buffer
To: netdev-bot+sashiko@kernel.org, hexlabsecurity@proton.me
Cc: sidraya@linux.ibm.com, kuba@kernel.org, mjambigi@linux.ibm.com,
 alibuda@linux.alibaba.com, davem@davemloft.net, edumazet@kernel.org,
 guangguan.wang@linux.alibaba.com, ubraun@linux.ibm.com, raspl@linux.ibm.com,
 linux-s390@vger.kernel.org, guwen@linux.alibaba.com,
 linux-kernel@vger.kernel.org, hidayath@linux.ibm.com, horms@kernel.org,
 wenjia@linux.ibm.com, tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dust.li@linux.alibaba.com
References: <20261029-b4-disp-33001ace-v8-4-f9bb96e17827@proton.me>
 <179364387382.3131.13471253186660322977@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179364387382.3131.13471253186660322977@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 19:24, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (2) · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch adds a cons.count < peer_rmbe_size gate to
>    smc_switch_cursor().
> - [Medium] The new bound in smc_switch_cursor(), diff <=
>    smc_curs_diff(len, &tx_curs_sent, &prep), is computed from a snapshot…
I think the above are the last 2 comments standing that need to be addressed,
(the high one in patch 1 is addressed by patch 2, the high one in patch 2 is
addressed by a separate patch).

Also patch 2 and 4 still lack review from the smc crew.

/P

