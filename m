Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106D3B0AE1
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246628; cv=none; b=nyJOjY0vJh+SGyUaqlOA6eGO5wQzOY45iuLcXx0VESMpblznxPRnDKcRiPi7TQvjecQXBIASwDTpw6JBY2Z1qzDrSLkSYCbaHEp635MkgzUXadd+Dx803feM6nKF4n/TzZJ7B/emoMAS6OieFCUsm2U4GvJ94Te7rct2IE112Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246628; c=relaxed/simple;
	bh=cYyqhGbOtch0OMgoH5rHeZBCWMljU1zPnzPnNokH5T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eq3E5cmG0gv1f/3IjgWfp40V/nmUpR8YRCgCS9TdOTpxIBCtPIM5rdGNKrkYHpgdcGgYK/VrDLVwMBWYJqK6jR8I4HHoNU1qleg0/HO7wyOzIkcyIUYM9oD6BoFZ/+Rlk5W5W3Y/L2jHi3gf51eWDv5EOuuSYpP0/EPhHbIJ6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBiUmGJn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PizWuvOd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBiUmGJn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PizWuvOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785246621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
	b=IBiUmGJnY81QNBRFYNMEa6Z3ib7fHe0zvLvPjs7oqxPyCSSQT0bdF9EfMZ7EyvCyVI7WAt
	1/DvKlOpyjBNNKC942fbQ3gxckiLXsYI+NMPQTFU7+O9j2NaqElk1FJSqOWG9DqA1yueYM
	Ne5h9CkKKE9A1vHe4dNW3c+e5eU2NGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-jY0S6WTtNHW3ttpVxWyg6Q-1; Tue, 28 Jul 2026 09:50:11 -0400
X-MC-Unique: jY0S6WTtNHW3ttpVxWyg6Q-1
X-Mimecast-MFC-AGG-ID: jY0S6WTtNHW3ttpVxWyg6Q_1785246608
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49545071724so40479175e9.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785246607; x=1785851407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
        b=PizWuvOdheSc5rwXr8t8xxI+fS1te9cVrH6jc3dR/WIPyYugjI0JDYz2QLbSQFPe3f
         VgiSB5HhsqERNEMurziLnRrDr22LiRuFr2z8kAZu9tRLWETNd7JXZ6WTO8QKSmJR5vU5
         82w38dHJ4MgSiss9PE66xg9ZP8i8hSwV34SA9SEv+sdXZ+TIHU8HHy0OiihW38fsK+tV
         B5/qPAtvZ+AdfvsF2Z0jmQFDzy+Ep4hPoPjKeUnxfaQZz1e61IiC/0PvgdagTWV5kPGu
         2I6XmbcS7B0amW3iDDG/aywpi9iLrAFRc5tKjM5kJek4loo2dRiJ/b6KeelBC5FQPj4g
         Zm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246607; x=1785851407;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVLPzsih7jHwttgXCjqiYK0PPNx9XxtuzrfSgVm0vvg=;
        b=Sfn1ShQpqbCPk6aGs2rZqJ7NmPshr84x2f5AVlBKT2Wu1X8+GdB6w4CWjG6F3N62P1
         M4HkobXB9he/37UZBiJIty5JOtJDN9fYZ7+eqVVMtHwoL9yEOsqh2kwJZ5PoLZTsZvki
         je1CWpQKmxOg/WVIgaoQvgqvSaJUg/oHu6/fhu058blaLFne+TvydTONWbIj4de/8h7U
         VgWr/OL9MFGmdWtgi317Ae98buInDijxLymzKFz/i/fPTj25v6Sf5SiPdCBlnlkchZnG
         vb8ncFiTKZZaTubQn0Z84dBaH9fSfvmB7IorslNQXw7celFq7yz+s6YIHH6+Yr5nHKK8
         tOyQ==
X-Gm-Message-State: AOJu0YwINa8HdbpNvECZDK4MVMaZtq7Hl5/JtyEVgeK/F6EOcgrfmtSJ
	FMMk9hflPZvSdD4Qo1rGksv9CAgo3W+hEbDoPv25z/gQfV2haMiIilMLaxV+0ZA75sP2xgICDpw
	WICNVT61PP+5Tp2bi5DfLcjvZEfUPcLPFBG4yYnFco/5Ol6AIY7XXu1V3jfbC+mw=
X-Gm-Gg: AR+sD11vRIUaKNfRSw4YO8Pj688VMKx/DADFCvuB+tW/69b0bm/wBOmCobnpXFSldBz
	gJ9QJPqE/FPwkC09CI0HKTRnNdn4xMK5oh1R0TAji9XbcNHzk2VTJikwL6YFZ/CxFvSgqmlRIly
	QIgO5/vnKKOKneiYdFStxRXHCpdUtoDUhpUKjOLvh/XH2+SpHWtEdxph3vKMhJPKAsUd8YP9iIz
	XHy244XGtdfUzW/mM0ykCnOtQlB2dnSwk+iR//tglByMsfv7WdCHpeOUAvajipN6DAglJf4GU0B
	jLxmrx6+AiFuc98we0ZL557wekuDKoSM1SFVQOajkjCR51ZGGTr/9hSiW3vZDP/Y2zaJsk0vjOY
	eNO9m+ikuIHRoZR/IildYImgCqpyYOJxJT/5ItFHsrkWDUxbn8IXgen9vzbu18Uz1JpMqbDNFyj
	M0gQ==
X-Received: by 2002:a05:600c:46d5:b0:495:4a22:d684 with SMTP id 5b1f17b1804b1-496c6439428mr31470225e9.10.1785246606606;
        Tue, 28 Jul 2026 06:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:495:4a22:d684 with SMTP id 5b1f17b1804b1-496c6439428mr31468965e9.10.1785246605194;
        Tue, 28 Jul 2026 06:50:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c297dsm76861475e9.7.2026.07.28.06.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:50:04 -0700 (PDT)
Message-ID: <4b5f67a2-5624-4adb-812a-bd87d99416ed@redhat.com>
Date: Tue, 28 Jul 2026 15:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
To: hexlabsecurity@proton.me, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Wen Gu <guwen@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Eric Dumazet <edumazet@google.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Mahanta Jambigi
 <mjambigi@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
 Simon Horman <horms@kernel.org>
References: <20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e@proton.me>
 <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 2:23 AM, Bryam Vargas via B4 Relay wrote:
> @@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
>  	local->len = peer->len;
>  	local->seqno = ntohs(peer->seqno);
>  	local->token = ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	/* bound the wire-controlled producer cursor to our RMB (used as a raw
> +	 * index by the urgent path); leave the consumer cursor unbounded -- it
> +	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
> +	 */
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
> +			       conn->rmb_desc->len);

Sashiko gemini suspects the above may cause a Null ptr dereference:

https://sashiko.dev/#/patchset/20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e%40proton.me

/P

