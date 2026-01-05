Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD45A59
	for <linux-s390@vger.kernel.org>; Mon,  5 Jan 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599254; cv=none; b=auUepc4NZubcUexiQTTn9+jOg02CT5AQ/oHGq2Nl81r5aUyHNYYg0MX6hx86oFZTtirQUNGJiPzT22Gzg7J3kyOiQbpo5qVQyouMiBTxmttnXyOTWgnMGQzUFImHMoVMaVRCE7LhQqgszoCeNiw9nkLrBe/eZjbav+wP0QZvRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599254; c=relaxed/simple;
	bh=nZVAqheaPq5rGRSWmaOVnJe8g46n6sKwiOrt8BkPTmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss4e+Ugx9DwmJ/c5eBHO1LjjKyXeOUNelB9ok87wbGNj+r9dp3F6ZnGZZDbtdBzhnNDy0I03vHqCRrH3I3dyFtRIz58m99tLV/Ck3LHI2cukPNwnpQNXfZsSHHOnu7/4MSpRTjZkp5SnN0Nqj8tSWo4ADVXo65q+SclO1aWZs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDKMJWyr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDKMJWyr"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c227206e6dcso13332021a12.2
        for <linux-s390@vger.kernel.org>; Sun, 04 Jan 2026 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767599252; x=1768204052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Smn7G9NNF4TKpSBrLZt6/rkru/ozPf2jYkxgsCOt/U=;
        b=XDKMJWyrvDbiwDOfmQKLltH6IiyxEaweMnOAZFBZVGTYC2GOqTfKh3n04lf5GJ84qu
         5s0gbg4aU+QvgUmtV7ytpI0dXCqPB+akAz5slCfWkIk9tIcmZWrmUxBoEwmp6kRQeVdB
         mWGTurcze4OqqRw5CUYJ8rQ8v9uWuLvqfyqXF/tOyXXg/195fsYvebVWZJ6Ki+oIuXZa
         lq8f2FsrXZaPRS0o17VkIPhBt2cfSseITAlkOoe59bKGSK7ub90fst0TVAjIauffDcOP
         3+BOPMFIVMQjTL+v2cHEnTNRAFpbbJ/cCITAJrPSRtrSDdpNrBJvN+U/6tGxmjdBBmBl
         8Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599252; x=1768204052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Smn7G9NNF4TKpSBrLZt6/rkru/ozPf2jYkxgsCOt/U=;
        b=lYzB08mk8PKX1qAIIuRQJ8f5jsMLx9Y839yvtBJPoKWqIbslGGvSsi6S7cQZ+qUwTf
         WuIiUyslNVdB8nTIcS3PgM8Frw2xo/k/mUuJddErmGKsttqYkt7DsNnvCjdVb89npjYl
         2te8IqJAluL1q2r0xC9UksgqWt2V1GtgQrW/4dyQeYHfW9DcG7HrYhplJXiAp5UJ7hKc
         aHuUmjLv0W9eq0+kzpyg8h6oZKFxguxCySgx7Sr1th2lb6v07OyHtxT5IpDcccS/NB/T
         B9r7C5yQ+YZ9ykryoxasQQqeQB1bXVc1VQrVfbjP16j+6CHiXbGLJneOq91OOvxHiMA6
         hNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURTkbkHt6tguck51ey8GjCOaDFcqhAbKnPWUq3BxVmhCnzjffROljA6lWqTg5ZD9OjlPVwBjGD+CLa@vger.kernel.org
X-Gm-Message-State: AOJu0YyGc/dbRGDv63c1XxpOrkYJS9w3wIN9IVqpooPPgBoA4ZkKTxBj
	69vSl6emqVE3kL3l3n6LbafZVSahDcCzNhHIU7Krb002164tjpXa2I3j
X-Gm-Gg: AY/fxX53H+/UXSNln/ZEM3G9r7JuIj3rTblDbICSomvvAoyaHnEiUL1gUil7Wb67hSS
	JFN22ZWqCJeQ8QGcK1I4M46vRhmJ6DQK4JiQrH1fLTPebPmpmQIFUrL8JopYgGH6ioUPLojnFaE
	1BFbnCyvm7W968mt4+UFBDYvWp4In4xFD2XCIz9P/i70COZSRbq5TZq824sAPRBvpiEXar/Eelh
	aWVjz/LMfS6Ilk0bFohRIwQDdKjky7C3nKuIb4S5llBZQXCPzAylwL7N+Z4UyQMam0SmnFyXe4z
	dt2zyr3tRJ/TfP78WshNSdZ1xX/PAIqpTm0XA9QmiY2hyb5iSNsuKWHAU8m+/XujbYCw6L0K19G
	Oi+X+1udtFvexqTttJzIog7CeyGYcPG0Os4tl0atPJ+SPMHUsjKMgkTE5J9f0m+2Fmvv5y2r7eQ
	==
X-Google-Smtp-Source: AGHT+IHVaBHzL3ldcoq10mQ0DvSoQNAzO29+h1IBrSy2gZY7Qh6quSoh5XWNmgIvhDzcT+gz+HyNHQ==
X-Received: by 2002:a05:693c:8008:b0:2b0:4f8e:3273 with SMTP id 5a478bee46e88-2b05ebd7223mr36936529eec.6.1767599252090;
        Sun, 04 Jan 2026 23:47:32 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0f:28::4:33f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffad66fsm101610210eec.4.2026.01.04.23.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:47:31 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH 02/36] lib/crypto: aes: Introduce improved AES library
Date: Mon,  5 Jan 2026 15:47:12 +0800
Message-ID: <20260105074712.498-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105051311.1607207-3-ebiggers@kernel.org>
References: <20260105051311.1607207-1-ebiggers@kernel.org> <20260105051311.1607207-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4 Jan 2026 21:12:35 -0800, Eric Biggers wrote:
>  extern const u8 crypto_aes_sbox[];
>  extern const u8 crypto_aes_inv_sbox[];
> +extern const u32 __cacheline_aligned aes_enc_tab[256];
> +extern const u32 __cacheline_aligned aes_dec_tab[256];
 
__cacheline_aligned puts the array in ".data..cacheline_aligned"
section. As a const array, it should be in ".rodata" section, so
____cacheline_aligned (note the extra underscores) should be used
instead.
You can also apply the same to crypto_aes_sbox and crypto_aes_inv_sbox
while at it.

Regards,
Qingfang
