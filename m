Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2843ACA77
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819739; cv=none; b=sHNUDXEEO6GOhWwHQkq/H5B6gSdgMGJY2m9AZGqNcK0eWQJtq+cBrhPoXlCeCNvPwlyBHxrbOB4x0SO3SNuns+tfFQqmlzcFatLxizFgate+iBoAuYCos8yBs9V4akS4EVkekxepYP6BSKSxE3EYGcbMH4hQgdon5z93ZhmUQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819739; c=relaxed/simple;
	bh=DkPnN0LBKMtrFx+X0M2ExaQxqAiphMY+jUqO2hdebNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksmkwueDuCWENLNajpA09CRhRVmrAjePpAdvpc28RPk5nmzVoFgmSTJdeFdTBKPY7oMmCzed99OCa3L0Yr+UN/0UH/10VwZP1fQdfwb7WCvu49u/L/pEBZ2AENQBvPGd4zCD8i6ve7QojyBuJXSRWm2M4a0fdYGCpr1TSRHAD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lp0IK5LP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBhRtjWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp0IK5LP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBhRtjWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788819737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
	b=Lp0IK5LPF0SAXWljyYIgJETY4Zj29VXFLbXzoc0/K7ZKtqe3OGpktWNTyNu7zNmr/D+QoQ
	SA7BgGgaasjbVHayg6kWRfPkwUfHOUF/bMPOOBRLblqLk5lmWGEFirTGUjJsljTzD3i8yU
	8WWZTjUKG0iBNtKWw/1O5bT7WN1aKFI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-qeRlVONcMJiUuABX2EF1uA-1; Mon, 07 Sep 2026 18:22:16 -0400
X-MC-Unique: qeRlVONcMJiUuABX2EF1uA-1
X-Mimecast-MFC-AGG-ID: qeRlVONcMJiUuABX2EF1uA_1788819735
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994aebe932so50605245e9.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788819735; x=1789424535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
        b=CBhRtjWFcz2nRsO5CDk7DDviVJ2vuW0jXF4TLOk6KsuQPNgMrgAZbkX5LLsvFiXLYh
         RV1IR5LZYGvafe5DW8dKhL+kYMvdCx9eqD7kw2RbXfitMSYvYmonZPiUBptR/Z6a47d9
         3pNyn8XM3Z1Yw9dfoWjKyd2JpeqtrgRFRBf9mtvVJn8Fx1aUfHKLvDLlPYzgYTVQYiS4
         GZp9e6ctzr36DKJQ9DdlJc9Q9vlHJPRQWHcwOuKJ0AMXOu8wNbWPSmvX9zxwMwLaFzmo
         Vm+xTuiriASQHR/uCMfPJcshmstfLXs3X9jzvHZvdAKzllG3PGeHE03sEDUzx43SGNof
         /wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819735; x=1789424535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
        b=JsIICMPSWh84LcoFvILGKN/E63l1edyeC+C72w6hdVQ59ofxMfJJOVWkIHMbC4bPPC
         VNDyHfTWZUNG4p0JMlNwRyMz4eLnyDK45+mkpbIXGCQ5+wHj7hE7gs8qQc86t/r2mjBe
         mDuKEn9Uo+Q2/sK3Klkwa40ncI9Q/rma1SXGged/++l3SPxctCQTZpDIAxHK7Bhv+aHi
         +6Uza8plV34YJd4S4Y3P1RorG7jSMG6JJgCwv8Dboqvx5uWDwvgDWbv0Bb11pUvCuaQF
         tgBhDLn64M7uq+11tLmEGdz8AH7m+6JKDqTVoYLJRube9ECXQgrqT5ySvz0APQR/4/rk
         Z1Tg==
X-Forwarded-Encrypted: i=1; AKwUvBxtit1u0+I82Qwi5VHZ56o7xOwOeNVITbgl5qVoN1YeMOHwgcpk4PwXPu24t2lCYwBanBKLwuzlAWpD@vger.kernel.org
X-Gm-Message-State: AFuF++m/iQnpuBm8+RWW7sn6JZL5LpG+Z19Sdhh3vBrsaJtGJXxlmHZT
	ag4SZuBPB53Ah8dDmeDQHqSLx7GlovARoKluGPdF+Uc80mOcEwzcke64duAT5yIxIbr9jRLL+MG
	qbUDgwDVdoR8ji4Dq90QS1EiW2lCbtV87S/Z70ZTfbePMEIFBRSZ2hSPBfQ9zxe8=
X-Gm-Gg: AYBFou3tBdwUzWxN97v7lVAqhIu2P0aMvwJCI46JwrmM4MjV6yMbpHXFDDUoOY52QK0
	OpQ9JiDs2ZvWeH/VKuFcl05AKL2B6Aq3flOafbT+vy0X81PG/70zYoih63eiTiCFuEwW/6t7q9A
	+a4G1HmWHSiPyFmoCem4AsKlVqfsToQ/Dojg6eMVSAOnYSZ5Kp4uidTE8nPmOqourChECEM5Lmr
	cqO1xHIrzGTUJtQEPzKCdsUOeyqNHf2DYUBznTewd514ldaW9/SRTG97QjiW2mcwmYDyprBwWz7
	6VErtm1AI2TIa/TDLx98MywjsHQ+PW7WWK7FU/uOFAZVraSSyvBnbwXIt/mYcREPdIo=
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086785e9.1.1788819734843;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086385e9.1.1788819734435;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
Received: from redhat.com ([187.15.128.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm24030241f8f.20.2026.09.07.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:22:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907182153-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap82pFlX8enNG0gZ@gmail.com>

On Tue, Sep 08, 2026 at 12:15:14AM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > > Assisted-by: LLM
> > 
> > which llm and which agent?
> > 
> 
> Claude Code and OpenAI Codex, each with their current models.
> 
> I switch between them and let one do review, the other
> helps with implementation.
> 
> "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> gives now.
> 
> Thanks,
> Karl

really? not what i see. in which version?

