Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CF457E69
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984523; cv=none; b=WG+5Lt8YVmht1+KtvqRDgdfqiUEwqpqr/UUODSr58B/vXoxYMYQ3ggX3iSwBBZl3nlqdhpB7hSf1mYvgJaesol1W4irRvqQu/SUpsbhpXlGCCK0XU+TiwGA47bY4Hs9h8MlsBaa5IEdCMDglvWnH3JWseEMAHeqZ09t6/+Vp+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984523; c=relaxed/simple;
	bh=7UPq8U/iRVN8XOda/8iZfxpKbzPPyb6X7CAqcWoNFFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqRQZDO9aP7aDUI5y6fjZuQ13w1VYr1Nn27qMSjQ/6Pm2zsBBbE90rAzVzKlWhTco0TiNFvx1+VK3qq64RsuRSjxJI6jDBlej8oOq/gd0NSioHepFK2WidNqFmEJMtUYddBODqqnzZMCoFMuclXCpnvlJtg4Fb76fp+TuQYoL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu+2xLyL; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu+2xLyL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ce364488dso7150225e9.0
        for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789984520; x=1790589320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JfR8P12V2dfyx7WlZJfhBwYaBNVarwlPbqKqcSq6ZrQ=;
        b=Nu+2xLyLn/kj0yTLZuoytUnKkMUFgfxij0tOX2NaCXvlyFUXyawb5gPdHkp9Hp+FEH
         Qdrbcby9PKezy8+EjB8Dfu2eQeS/vZYiAb7KbgwJdyM4ko5aF10ES3h1KSG2pC7wFVCw
         EEO19wFt9xoe5w/xnGMzVOjqPkkgGZK9/FbDZU9D6Ny60hZeETH1+xJHjonxoD29yvL3
         C7IYLPae7dBSqeKtb+rMXt+Z/FjpqULgnSTumhVlz6gwGrW0rt+v3rwOAYM7SucjV4EQ
         WjvgPyOIvrGfcbLcAA/BguYh8RX6UV7oMr+K9UMPEZVWaVZW4oBnjzsIfFZ12rHVxiGH
         nsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984520; x=1790589320;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfR8P12V2dfyx7WlZJfhBwYaBNVarwlPbqKqcSq6ZrQ=;
        b=EVPNhfBiD3aC+ZDXuf5c+3JRt18Os/ghNPNBP3+NniIPXKxLYmy4kipBCrwhZvclj6
         aBDGVVc8ujB4wmTYmLrlnCzT7v/GsJezP2cBmdPK8MUqzCARY27uaCJA6wPsXKDwaMAC
         fSarXO+NOhaMf9etLnfUYe1FlRMFxVVYRM36ksksUbtg6yC0k7Rk6uoh/x9XtZX8abxE
         nsJxJ7rDdXiGIBJUlOHx8yJQxyl2s3E33VMPvHchFYFVYlL5GBggDsxJxxgw2wgZbVzL
         1yhV3DHD5zKvWwlqKHgEz6XytaeSP7O7htze9+0jCj9NmOVkqLbj8FViF2KzzxhfC8sU
         Kxyw==
X-Forwarded-Encrypted: i=1; AKwUvBzIVa9YylfJU6nDXwrWlPp5hpTxkxNHa8TqB7VxonxSIMtPmYCnwOhHCRmuFn2kYjorfBQWWTndrOHx@vger.kernel.org
X-Gm-Message-State: AFuF++kS0/8sCdMMfIGQSgzCiGIVsyvSzZVpAE3LpDzjHAAUC+nlIryk
	jRw70pNSic6ZCMxr4IQJkJ3WujKczRQ3ekNiBb7mKKEd1Vg9ke9U7SjA
X-Gm-Gg: AYBFou386SktLhjjMwrVnmuTyL130/uZ/uTQEAi9xMgK1uyfKybQRnBiBX7eF0pdAh9
	ea1XY0HR6SZgcblyj/JQeKoAc48KBm+Jv+ZUcgsekI0GoL0t/vBFSYJGTvLB5iSCbaguQt0kdOf
	ucsttLMDUj8uLjWUmpJjqx0LFpz+wgIYtcId10vcVwWS3255NZWPCRsPoN1dhOb2jEZkvbPZHkC
	XRVo67V6pZRLlBZtBJDn2umkwMp2fcMvDXePpG/qsgxTmnXFp+KKZWTKDUpsgBTSEgDOQhzwUMs
	0cDZguENOiBl8+3QHXZ8vpxm81LCObguiJjxHqbwEBE/P0/lrUoOVO6dKX3KkKXxZ4Cd36Ookgq
	Bnj4lohwO58KDLD1OgPsf/bvwJJPA4FGg/YOBDdZYlPMPvXEKjQAxQzPGjrnx3XgjqCS5kjhrUV
	ZfIKGgiCjPteaXbaNCUvuuQVk+2L0Z6C0WuV6aUJhlfplce7GUnmsyEEuzIans3GiUYYJZWecej
	J7UwcCSV6efNV6xqfs6JyHipwIrRAnI61W0QEl/NJNTj/Y=
X-Received: by 2002:a05:600c:3f06:b0:49d:257c:a735 with SMTP id 5b1f17b1804b1-49fc4ff42b4mr158855435e9.11.1789984519697;
        Mon, 21 Sep 2026 02:55:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm225054205e9.3.2026.09.21.02.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:55:19 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:55:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Juergen Christ <jchrist@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 11/11] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <20260921105518.26f3dcf7@pumpkin>
In-Reply-To: <20260921084005.4022574-12-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
	<20260921084005.4022574-12-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 10:40:05 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> The percpu code section functionality uses a rather complex method to
> figure out if the register, which contains the address of the current
> cpu's percpu variable, needs to be adjusted.
> 
> If an interrupt happens within a percpu code section (indicated by a
> lowcore field), the instruction at the interrupted location is
> checked. If it is not a specific AG instruction, the register needs to
> be updated. This mechanism needs to take kprobes into account, and
> enforces a specific instruction ordering.
> 
> Mark Rutland provided a different solution for arm64 [1] which comes
> without such limitations, but requires to use one more instruction, and
> two more registers. Given that this simplifies percpu_entry() and
> percpu_exit() it seems to be worth to go that route.
> 
> Change s390 to implement a similar approach. This requires to encode
> three register numbers into the "percpu_register" field, which is used
> to indicate if a percpu code section is executed.
> 
> The used mviy instruction can write only one byte, which allows to
> encode only two register numbers. Use a register pair for the inline
> assemblies, and only encode the even register number of the register
> pair to work around this.
> 
> The generated code changes like this for e.g. a simple this_cpu_inc():
> 
> Old:
> 
> c0 20 00 00 00 00  larl    %r2,c6 <foo+0x6> <-- load address of percpu var
> b9 04 00 32        lgr     %r3,%r2          <-- pointless copy of address
> eb 03 03 c0 00 52  mviy    960,3            <-- start of percpu code section
>                                                 - gpr 3 contains percpu var address
> e3 30 03 b8 00 08  ag      %r3,952          <-- add percpu offset
> eb 01 30 00 00 7a  agsi    0(%r3),1         <-- atomic inc
> eb 00 03 c0 00 52  mviy    960,0            <-- end of percpu code section
> 
> New:
> 
> c0 10 00 00 00 00  larl    %r1,c6 <foo+0x6> <-- load address of percpu var
> eb 21 03 c0 00 52  mviy    960,33           <-- start of percpu code section
>                                                 33 == 0x21:
> 						- gpr 1 contains percpu var address
> 						- gpr 2 used for percpu offset
>   					        - gpr 2+1 == 3 used for current cpu's percpu var address
> e3 20 03 b8 00 04  lg      %r2,952          <-- load percpu offset
> 41 32 10 00        la      %r3,0(%r2,%r1)   <-- generate current cpu's percpu var address
> eb 01 30 00 00 7a  agsi    0(%r3),1         <-- atomic inc
> eb 00 03 c0 00 52  mviy    960,0            <-- end of percpu code section
> 
> In the above "new" code example 33 (0x21) is used as indicator value to
> mark that a percpu code section is executed. This value implies that
> registers 2 and 3 will (only) hold the percpu offset and the current
> cpu's percpu var address. Those registers will be updated by
> percpu_exit() if the process was migrated to a different cpu to contain
> the percpu offset and percpu var address of the new cpu.
> 
> Note that because of the pointless lgr instruction in the "old" code
> example the two code sequences have identical size, and it looks like
> only one more register is used. However this is because of suboptimal
> gcc code generation.

In both cases the register dependency chain length is 3 (ignoring the
pointless lgr) so the execution time is likely to be the same.

...
> +	regpcp = FIELD_GET(PCPU_REG_PCP, regval);
> +	regoff = FIELD_GET(PCPU_REG_OFF, regval);
...
> +#define PCPU_REG_PCP_SHIFT		0
> +#define PCPU_REG_PCP			GENMASK(3, 0)
> +#define PCPU_REG_OFF_SHIFT		4
> +#define PCPU_REG_OFF			GENMASK(7, 4)
...
> +#define __PCPU_CALC_REGVAL(regpcp, regoff)					\
> +	"(" regpcp " << " __stringify(PCPU_REG_PCP_SHIFT) ") |"			\
> +	"(" regoff " << " __stringify(PCPU_REG_OFF_SHIFT) ")"

I'm not a big fan of GENMASK() + FIELD_GET() and I'm not at all sure it
really helps here.
Maybe:
	regpcp = (regval >> PCPU_REG_PCP_SHIFT) & 15;
	regoff = (regval >> PCPU_REG_OFF_SHIFT) & 15;
Which at least uses the same constants for encode and decode.

But I might just comment that the pcp register is in the high nibble
(twice) and remove the 'crud'.
#define __PCPU_CALC_REGVAL(regpcp, regoff) "(" regpcp " << 4 ) | " regoff
	regpcp = regval >> 4;
	regoff = regval & 15;

David
