Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505341;
	b=cKoykyGXVsA2kcw0QXKxMUEnhIWNRszS+6IlwQTTj4BK8dAGAchMILsuPDXxIl5T6tvp
	 h65b7qyQW5OsvNus/lMGa3oCznX4Xgju/zghjE2GVsGqofQ7dkFygGmxBZWVfdc+yR3ez
	 z650BWw6Rh+ztYFOpNGPBS6PI6n43eQRLO+alYa6WASZrAN7dkIXjsHpCmx5JmCZirXQV
	 slT9HvC9t0V1F+NKH+kZyiA25GVxhckmYxQpJTNv3KiwNgu1ATMga+eaUxi9DSNEUP8Cr
	 r2lcmpA3ydZVB6hC/lu8hBhjsFrbCKYW6zBvc+0pevdlGM2kO+Y5bbMkepl7S7CXypw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Yqn1FO4I0DjxyEV4hfY+IrP9ze/3wMUKhm1cvsmGmxg=;
	b=DuXD3YtYdhVXdwPrhfEmm7mIrsWzlW38VzchtyC07qi4HYAXT3M24Hx0UkxOK29nw/Wl
	 RSOEzLGwuelG2GjYgytwOmxfD+2YZUfd3g8JNSShdvh/Ys5t/wLXEyHMm6yDrF49Yb98u
	 PslXElHFIBYM1kaFSEhQUdTlLucFEuC5XDMsd6xutLal2tAZ/kyLZgL8SoXzg8ubD+Dep
	 suEiPIsO7PR0I+BN4D+r6CxmN3Y863CrVDtC2IB7oC6C2HdRTvJXn2Q3M6R/DLfOHqrH+
	 iLoux5FUfirVqJw+11v5tKzVegFmVjzwR2N+Jz9z8vJkGwihAof4w6V8XRILN2CnrVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eVmdPbDV;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CC606A326
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 07:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eVmdPbDV
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so2118444b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 23:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795505340; x=1796110140; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yqn1FO4I0DjxyEV4hfY+IrP9ze/3wMUKhm1cvsmGmxg=;
        b=eVmdPbDVmfH1o8pWxxbI3Vmh0fdBbigCHIOHo5tel2MDsgA4aVqTNhiKU8AQr6+thk
         W0WTPLnD/2fPw8zo5Zqsbnj5PkgWpIdOdZEgKC2CBgV6uYuMDOWL+f80RgByu2unl9/q
         XR0L+SI2U8yL1e1Gn36qtKvwe1eRYbX9bygrL+iVoDv34xXhbkgc1R/wrF5DPdjo2gWI
         At1mDGofxLwNuJ9EQoBwQkb/61yoi01hbT++HufcG6J2xD/UUFRv/x2PF/ZkHq40LHh+
         LF+6ofMTJk5MHwa4t7sYLO3Y0I0QXSI2xQaE0HjssG3YUOY/TwvIgHtd3wztjOZrCBZq
         F6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505340; x=1796110140;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yqn1FO4I0DjxyEV4hfY+IrP9ze/3wMUKhm1cvsmGmxg=;
        b=yjGb7Nbwn8Uge/Mdyz1QAe7GSY2dZn/femUqvpSCmVawu/8Qu9akSfXvB01MnrzSDM
         ECyyEE8Hj1RbwmtG3dWRLxP2JsgiCW3DOpIWV0bpYF+fBtiUNbeR1Mjspq1DxbWVJ5wa
         yaSP+c5Ki0qP2BEeLZpnPUz5Y8fBNPL/PsrTCrMr+VpsRFM6FvlmOsg/Fqc0HTbE+3Yv
         0Ltz75KfE0sUoCx1d8D1uijLNT4miG+wuAiYAyFyQSOFhvLM7TrBXh9Shw+lr35C+tH8
         iQXYnM7JDCcS9Z7keen/aBx4tbc3qlQlELlrBCm4YtJDlR2+FaoDu3wSL68lnRANRZw1
         6+gw==
X-Forwarded-Encrypted: i=1; AL+hErHK+mlTS4NNwJ2OacsXSSdfSIwsgg+od932Nd0DBrX+rIIKthVC+vsHGw40KLxfC11LCNPFj/yd0Pc5@vger.kernel.org
X-Gm-Message-State: APuU4Z8JpW2IZ7LYL8O4HzlU60fBtigZPqvuHHIaeZc9Fz3Sjge9mic8
	mZ0jCzv4qevvgc/se8bWU1ie6C6briWzDso+hdD4noDl/ws1IhP5PgUx
X-Gm-Gg: AZFdTZew4ZEpypN0aWHJmwdnmm2z+aKhifpNimH8ErneFIRtyb+1MkabWmQ2NHPtUna
	ZRMqvtlmEHrC9sLoO0JbTIE3Bkx7bsaO9bjf+YuKczyXCu9xTUFJXOjwOWRy2RieIMIy5jx2lIY
	s2ZUjAQ/1UYtoTb7ANajOWWkGi0aMi3BjohR0bM53EalaNU0PDm4qipMmOPkijDULtyfAgAHGro
	ioV/KwRXmGpcTGjMOb8/ao1/8BZJZP9EhQIJwc3ZFxEk2WRkZdMlnGUa7oQYpEcK/SihashkvBL
	E/W7yT8BA8p3SCYWOr/3todiYVtsxs38fNLIyCLvisgNO0pGO/La7maJeZHaYsumtpszBaEnhHz
	3VXuAVn97Q7kr3DzmjsfsLuqXbZOuQW4beBTppz4761yhrOjluG01aGfM1uRymdREW6TSWulLMZ
	nvdnHkOeLdc8LYZp32DKIJRQye3nNeykm2wvqohi44AfRDOqipfIlXOWwLn3bFaG7xod/nPElr5
	E2eaQq0vcXkw/2bkHeRTcMvUIVf9z5/3IjOkHp4tG0k+NB/BnTABPVdaHFhMyUypDPJ13QA9QHn
	zU+a6kRLtDpga2nOgMiMD362UcH99v8vb6VVma08zrTMJmtIF5O9rc4xMMQ6cELelCDF/Rj3RNM
	nvwCZ3d0NbQbxmqOvohnU/O3OEK4+GCwafQp/
X-Received: by 2002:a05:6a21:4383:b0:400:6860:e8a with SMTP id adf61e73a8af0-4014d35f22cmr12901584637.46.1795505339693;
        Mon, 23 Nov 2026 23:28:59 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm6643068b3a.10.2026.11.23.23.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:28:59 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: validate peer CDC cursors against buffer
 bounds and window
Date: Tue, 24 Nov 2026 15:28:53 +0800
Message-ID: <179550533320.20886.15449362529729238604@gmail.com>
In-Reply-To: <awUPgw3EGv7ATYRS@linux.alibaba.com>
References:
 <CA+OT+ON4Lt9mLvWPK8rUaHKZ01_p0fGCiCsWHwXWzT1sGaTtLA@mail.gmail.com>
 <awUPgw3EGv7ATYRS@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Dust,

Thank you for the pointer and the testing tip!

I checked Bryam Vargas's v9 series (specifically patches 1/6, 2/6 and
3/6) and confirmed that it covers the same cursor and accumulator bound
issues completely. Please disregard this patch as superseded by his
series.

Best regards,
Qican Ma
