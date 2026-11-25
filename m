Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598328;
	b=I8WXsBIQ/qY8nGXt2R7tKHo/Txs2OzC/gooIQMdSX9QYj/tThRCufPB0yaJ2o3mBocSI
	 Uzw01P0AwcWQpi5bCaSCwKha/IQP6wxfYjwR4b3M0fZSfhBpVh1i/ONVpXgdOaZFlcNQz
	 8mipTx5dioehBToKIWmFT+/qjoxfM+CQDrg+eWjZ14agr+OTpShnnEOTmhEytmlOuDuOY
	 2j2UP27jPQBe5BhRS7pil+g4q6laUvCHb/Gft341cbIEateINgDgAG8lRJTpnbSbTF9h9
	 NXBnRzIfQvet1vbTo2hEIxUBmR4QU9FoNydsxqJyGEZwPz8VcH76P777qg6BB8i2aww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
	b=hSDTDm0/ITs0XxGr30IRNiZF7cD7WDD201/fyHEDY0qgMB5ybqBhXfLkgEK4df/ovmDL
	 gwiLKmOK0KlTTt3zLs8AmJlKmNd5sWj45Q00mc0Bu6PijcEs8qAKEdFBLvMzKsNdvw3Jd
	 naln/XK2xX/5PKLros2tlXLE3rLVIqFSecD+NsAkJk3DexYSVixTl+1b8yc7cYhDWVkJ9
	 MENQu0XNmw1QQ2L97fPPqWBP33EDuGuMX8NDtfgmkqhW11dZuAWgg79Xq5Ce8pB0Fqo1o
	 nhqlBm+v1c77Ry6NG1kfSK1YBlpKYRrW2y7Wrt+85IqDm09L8Uz7I6Z01EWPasPZM5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EBAjagYT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B3606A32E
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 09:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0B3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EBAjagYT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso52316925e9.3
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795598326; x=1796203126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
        b=EBAjagYTDtXb640X/LMHtmRmHPx8TPwRLOZXR+yAF4KZjGFD+8DVhHZHmT7RuUuBWo
         mvf6Za3XyvOXl0UpaX/caa/fPJxmqzUEc5orKXrb8WRR1aCwKmvrIB5l1ckTmufObfT3
         tgp+T8TJeMf9BweFFB9/u+woxehbFaugstbdDgKwEJNWzydE6ywZrQTJSDsJ7L6Ap93C
         shZKGAamOPiEYNRdJkg1KediWJVEXvDQJ7XXlndkKsMqjb9WYk+P7og1odXvH47WnDEs
         gGWI5ART/BFa51vro6SJCGwTxDZrRmXxorrbBRWgt2HTU/2K21erjmx/OewaCYCKzlog
         PVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598326; x=1796203126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
        b=ZuugDUiZFm3rdgjaDguCm+DidjBUi/TX0rAN6pMKdalT2xkW8olL8DOdf4KFt2WJxR
         kT2h4Or6NRSB9byUfUbKeJjiitv+xIb3PLdOpCImYq4Jjt9gWFUnB5S9Yo2RBKHXdCh1
         WT0bcsKxwDPwLvaxxC2ezDf+afv+Jb95ooWFbRkfH2ehQiojchZTgmlIUgbHTcb44k1f
         /JYcGTgx6APiH5zicM/t8VWBpW+in1xstSFPDSC3rYXFAzLt0IfGkDOoGNni+kGRbOHl
         KjtE/TjKQlSjkR+fhBy83j62L0mugxB/Lwwh0MMKviBkfVF0ngYWxHvYwD8u2pjMvSnJ
         U5ZA==
X-Forwarded-Encrypted: i=1; AL+hErEzTgPZxbkNi+IFwP9I1vQeFc+R7QYH6Zfnw5MT+0WYmd/EtLTZQi78F4GNVtEwvIXy9Y5myRPPLKWA@vger.kernel.org
X-Gm-Message-State: APuU4Z/DGAFKGBQZfwlWwCDzZNLjPUffLYXUuNP18ikxC/YBqCK3pEzf
	f6eYp0BZltyhWpQgmVQQLc6j8gGdE/Deq+cP5THTLpCPHAMGn/iIluJb2ksYAo9rrrA=
X-Gm-Gg: AZFdTZeSHwCtUkOlow5bUk521l3y0/QGxBgUpqeN2IOluhhKF5OZSdMouW8Fyc73BrU
	WRptdK8NYFdYQToKKc2SMI4mEg31WLJZIrxVUEbFwdiYUq/sKUlGabvvF3zmUMeRAwSVwXLwqzM
	D6b1LVBZnaKDOmz+8CWrrA7vntcL0EwVVp65FebfuThNV2MTbFxwILccJNHUyCqCWtKtOQSDTnn
	HoEaIX/swqA00nXK8qRk5rdpOgxqRZIGDYnBXffJiVUummLX/woErk1wBMAjgk5MIhLiPcRi0rj
	9Eq/A7ScXBhXRxlHEEYN8QRqCwqm8sClowB1t6+nCEPgve/NLfeZV+9+/KPEuWitTHs0yyz/i+X
	VmQDhMyFRJk7yrwsMmztc4OPdI+x43zDzd168mmr6U97UeayOy+whgMxwK4l0HVN0gW6DXcecQ1
	CuK8qq9ut1z7n6mJ3zAUUue79EEQ3JkIa8D24wBAxoJzazOJGRsLKIjsGFsP/zqXbJr0jbd2LaE
	SzgdvKLxCgbYsgmQ6cgGvv41AQsM1EgZP924+o+VURq4jt9mmawAZy/jl7gOZDXcTT90IlFEGd9
	yM4A9E/RR51rW0aacf4=
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr364901185e9.30.1795598326473;
        Wed, 25 Nov 2026 01:18:46 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b34e9c3ffesm16850149f8f.19.2026.11.25.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:18:45 -0800 (PST)
Date: Wed, 25 Nov 2026 12:18:42 +0300
From: Dan Carpenter <dan@pereq.eu>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awan8mSx5cbzXzJ7@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
 <awam4std0Zifdn9k@stanley.mountain>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awam4std0Zifdn9k@stanley.mountain>

On Wed, Nov 25, 2026 at 12:14:10PM +0300, Dan Carpenter wrote:
> Let me add the s390 maintainers to the CC list.
> 
> I considered doing it the way Sashiko suggests but s390 doesn't have the
> __vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
> not the same so, either way, some of this is going to be specific to
> arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
> across a reset.  The s390 maintainers could probably take the selftest in
> patch 8 and modify it for s390.  :)
> 

Actually, never mind.  This can be done in kvm_reset_vcpu_core() like
Suzuki Poulose suggests.

regards,
dan carpenter
