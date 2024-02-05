Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB43CF63
	for <linux-s390@vger.kernel.org>; Mon,  5 Feb 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150110; cv=none; b=ndcqbsxE3QNDBF0E83M2eTmoy6czIZ0W8RGvjnLVNVSLGtE58hu8oAAKR1WHHKEhBTqR0dsl8YMKEm9CuM/Wc+Cn6TZ4lyFApR9itggUC/Lx0ZstyK1WJUa6Kj6sEYrzsHrD32uzKgiYFYkSJhlOS6jz41qDxZIX9dI6Il8d1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150110; c=relaxed/simple;
	bh=IXbS5jwsg2soia7aLFCzN1PxbuLT3Im8P95YoAzLLis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3+9rxZvIx7IPXXK528CRScAswKENaDmNfqP8GVGB0gFhk6OnSPCdEKO+kPo//aN2UALC/mwYy7RPoWkUAsuoGE85vE4virwuzlkAe+HgVyJ1u+llYxthkrxnhzfGL0yFR2V6QKJJuRCRPyuX5xvpIcnyj7ZoQ61Y/FqX8HT5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nvybJFVt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvybJFVt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746ce7d13so37645575ad.0
        for <linux-s390@vger.kernel.org>; Mon, 05 Feb 2024 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707150108; x=1707754908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZwZeufc6RF0LGvmSyP+thskIiStXIaE1teIek3hvHg=;
        b=nvybJFVteIgFCTbRfJdnY04Rd7s+py9FJph9J1Ip1Yg1G8eKhVHc2v8SztDGWYdUiC
         l3ysn8gAqFgCGrofQ4rRFHfr2apTwq4CeK61G8RFn4fInjlYUcK8lFQPq97+udM7tepz
         MijKsAAtu/e29FRDISRXAt3LWwEE9VgvW9HnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150108; x=1707754908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZwZeufc6RF0LGvmSyP+thskIiStXIaE1teIek3hvHg=;
        b=j/Z4JisUEWzuCZFijQTZKkZAohxaLWoKeRj19HeIc+hdarBnifu++qfgO3j9BNnl67
         U0FxwTaDMovtawOJuWTkXlq0OESu+Kzbdm3CO4dOPFUMrpbemMhwEY6HWxcjiWEAujQf
         NdvOd8WY2wXiGDfv3is374L9y8F56kzqVizKT73xuZlgxMIx8fL+odhiX09aXmUAkcNU
         hW2HMfaNV2+mDJux5GGI4jB5dzMpUGkop4dZjACwJ2dMNuX0f7dBuR/YEpmkx6UbR4XQ
         z4rPIhh9wczJ0din1yW/F0CGKFyg/X8ikRYSEWcxYjIKeXYnPG7oDLGhEMuxK5qrPE19
         wEVw==
X-Gm-Message-State: AOJu0Yx+IBfAr/svx5F53HINJ6R71JbsuNa0zHD085W4GQK3YTZbs/Zv
	D87uXU25TwAylXoRgNCBIWH1o2QtCYRmoBr64yhyiTsrIPY9tHermsqYvETb7Q==
X-Google-Smtp-Source: AGHT+IFOi6SKmDq+rEHuXD2yZIUTwg+48hSe9Nl9MGs2+LH2Mbti05+94D2DxPC7gvcjww9srmpYXw==
X-Received: by 2002:a17:902:d544:b0:1d9:ab92:1550 with SMTP id z4-20020a170902d54400b001d9ab921550mr6160873plf.63.1707150108625;
        Mon, 05 Feb 2024 08:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6WBBeNWFvorF+DbpeeCWedea/8Hkd20BNUPZaVZN2ePQGBivtHSul7DKIIuJwuuF2cfCRt3rZQEuOU4nr1E091Z3sguDmfGyKCX9U9vDmUvI/9caOUHHvwesqbnybtOo758qz4hn00Rp8Wgs1iXMzkg38eh7if5QgTNZviORqXScYOWUg19rqx7Y3peu4C0l59fwnXixxz0MOLr40N4QoWjp6pJEwQayI3wHJ
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001d88d791eccsm46955plb.160.2024.02.05.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:21:48 -0800 (PST)
Date: Mon, 5 Feb 2024 08:21:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __uninitialized macro
Message-ID: <202402050818.B11CFAD2B@keescook>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154844.3757121-2-hca@linux.ibm.com>

On Mon, Feb 05, 2024 at 04:48:43PM +0100, Heiko Carstens wrote:
> With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled the kernel will
> be compiled with -ftrivial-auto-var-init=<...> which causes initialization
> of stack variables at function entry time.
> 
> In order to avoid the performance impact that comes with this users can use
> the "uninitialized" attribute to prevent such initialization.
> 
> Therefore provide the __uninitialized macro which can be used for cases
> where INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO is enabled, but only
> selected variables should not be initialized.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks! We had something similar a while back with syscall entry:
efa90c11f62e ("stack: Constrain and fix stack offset randomization with Clang builds")

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
