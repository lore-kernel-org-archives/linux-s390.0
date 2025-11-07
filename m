Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BAA30147E
	for <linux-s390@vger.kernel.org>; Fri,  7 Nov 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543091; cv=none; b=OzbJE5ttm3V45rhVymIsFHqBZrzPEaDGvXafXkvlA5GJaXoJ8P/XD/0DAnVsWYP/kzs7D/bBZo2oDsQNnVR2puMCDm2b2RuZhLIa68fh9dN0Vv24wblfWCyKQ4iIJxKwySjOSi2DIjs90R0gBuCdsUJbu5Cg3s3UrO4hgD6BVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543091; c=relaxed/simple;
	bh=HMX+nokK9V+QGgu5vvY3CGRBUupf3RY/CVnmsPQBGss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j685c8d089K/VbccMS0oO4BJ1Jc7H+5cFWmjErnkcr1opHegnUva6cbjZ7WyKJcCVeaM564qEiRMcL+UzdxeOg11ak9+7bjlTYGvG1cFXyFG5VaqbfjfobufqCegIog/d+h9NfA/J9DDHejB+QIA52dxWGD9WPjESpuwbjqqQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcAsSnxx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcAsSnxx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47755de027eso7933115e9.0
        for <linux-s390@vger.kernel.org>; Fri, 07 Nov 2025 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543079; x=1763147879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoyRAxBYJ97KZHdMcvP1wI7gdZM18PW/SDBquVzm/CM=;
        b=PcAsSnxxk/vQ8EKi7S/zlpRriabJ6LStD3JjS9iMC1hHhA7ft4Ly8XN1F4KNak3nE2
         Azx3zPSFn9dNxBWGFc8Q0PGil+tYqmpuTWwYxIYcIv2G7YxmW3RVzo4tPDRmdwHnyFth
         ynrZ6laqoBE+okxBPB7YOgcbfSg224RvjW7uKp1kV2mq83jDvblTIbsCss7FkO/MeMHS
         RCPwKZblpC2N9yZs2vcU7+2qCYut6DMlTJQqMyeCk8kWoR0SyuT4q2Zn0GDbTmVagkQk
         BwFyCwwfWNcoAPNAbbVmaiVFIQmtAWK22/WHTHEAf0VvjzSO9AE7OeanDvGjh94licgb
         Tr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543079; x=1763147879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoyRAxBYJ97KZHdMcvP1wI7gdZM18PW/SDBquVzm/CM=;
        b=R3tHmn5CXKeceY2tsSul0BDUiNa9Ec0W83HoAaPAbs5v97BLCfwwpK0xkPzqbQUo2T
         Ml1876nqAStsQ35+Sd10cDdy06WOhRSllw9mvIYlMJ2YWhk5aT73Uyi0nlm8IzrUh+JT
         NU70q/ZfGh0YymiQCxP5J8R1DrasjmSU4DAS+qdVtZ3p+Hbb8sPxO9sGp9TWxu8aUDAj
         Kcat7kfyexHG+X/btNWzOPTi6VTWS7mb6SqL4QHHI/AuaisXDxdjYj1miCm+kIEVWiMq
         wrlLoj4OTOuCEXiLP3ixdQSoa6M4/V7d8rrWuu+27NwerqCfr8Q0oQj/wQDK9b47Bg0O
         I3cA==
X-Forwarded-Encrypted: i=1; AJvYcCVVCKEG5h/evG1SdWcuOavc/iLEd4LZvglatO95VEeU3ZRd/oWJpIKoCYC5fqzN2JDX0kDme3316Q3L@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4TYyrbUUGUzlkqYXmqPF7mpOFT9g6kZ9a9NCbahMDWPiLXIw
	myfWJgedteY9aZN1PzT6i02UWf2NTW7n+ATqWkLXbAxj7moOlqj7NsQR
X-Gm-Gg: ASbGnctie+9wu7gHDYtGY6CkfP/EnlJ/nZFVTOXwzAq6TJpJ1BkQPUwAkZ/EzqdqDS9
	fdYgi4fXnm0JZ2LdxGn7+7BmqucmuYTUt8CozB1Xf9gDb5gbq9LfJBZ0y4/2x0afWh8PyJ36ZNd
	HfyR4UHmI62wHfRiJyFxO0tuCghe8NloP+Mq0cRX2khFMSV3058ueoDdtxNO4joghNtEdmuG7oN
	thsUkianoNXS1I+DfRkKeP/5eeUC6jo9j8lHP8Hm7wq75/9Nq429RiobOFJ2cAGSTuugubSr5wn
	mI69O1Do0Q/3IlBjCCKm1kIy0L9tzrpZLrxDvZ79j/solPaIWEHtAKywJmEJoPuyeDWTZc8m7VE
	M/DrxBB6HlTXp/BIdDOcSnogRlGp5KAbwrpp+PirSqgjTANaqRY9yZAATuNjDlmV3FPDxxvZ4Q/
	KRH8+pHaYNwqsrs/kvogYXBbuXJ6IdEIZLQM8QO0d5mel5cx9HpqIn
X-Google-Smtp-Source: AGHT+IGwWldiHMKs6o3o24t2zUapUEv2nDiVIW1qgftMpp+s7M3k154xFpb/vMUGopieuIUWMdpZmw==
X-Received: by 2002:a05:600c:45c7:b0:477:55b6:cdd6 with SMTP id 5b1f17b1804b1-4777322f0a4mr1228445e9.10.1762543078570;
        Fri, 07 Nov 2025 11:17:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm6811350f8f.10.2025.11.07.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:17:58 -0800 (PST)
Date: Fri, 7 Nov 2025 19:17:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 07/12] uaccess: Provide scoped user access regions
Message-ID: <20251107191753.7433d2dc@pumpkin>
In-Reply-To: <20251027083745.546420421@linutronix.de>
References: <20251027083700.573016505@linutronix.de>
	<20251027083745.546420421@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 09:43:55 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> User space access regions are tedious and require similar code patterns all
> over the place:
...
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_user_read_access(from, Efault)
> 		unsafe_get_user(val, from, Efault);
> 	return 0;
>   Efault:
> 	return -EFAULT;
> 
> The scope guarantees the proper cleanup for the access mode is invoked both
> in the success and the failure (fault) path.
> 
...

The code doesn't work if the 'from' (above) is 'const foo __user *from'.
Due to assigning away constness.

The changes below fix the build, I suspect the code is then correct.

...
> +/* Define RW variant so the below _mode macro expansion works */
> +#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
> +#define user_rw_access_begin(u, s)	user_access_begin(u, s)
> +#define user_rw_access_end()		user_access_end()
> +
> +/* Scoped user access */
> +#define USER_ACCESS_GUARD(_mode)				\

#define USER_ACCESS_GUARD(_mode, void)
(but change all the void below to a different name...)

> +static __always_inline void __user *				\
> +class_user_##_mode##_begin(void __user *ptr)			\
> +{								\
> +	return ptr;						\
> +}								\
> +								\
> +static __always_inline void					\
> +class_user_##_mode##_end(void __user *ptr)			\
> +{								\
> +	user_##_mode##_access_end();				\
> +}								\
> +								\
> +DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
> +	     class_user_##_mode##_end(_T),			\
> +	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
> +								\
> +static __always_inline class_user_##_mode##_access_t		\
> +class_user_##_mode##_access_ptr(void __user *scope)		\
> +{								\
> +	return scope;						\
> +}
> +
> +USER_ACCESS_GUARD(read)
> +USER_ACCESS_GUARD(write)
> +USER_ACCESS_GUARD(rw)

USER_ACCESS_GUARD(read, const void)
USER_ACCESS_GUARD(write, void)
USER_ACCESS_GUARD(rw, void)

> +#undef USER_ACCESS_GUARD
...
> +#define __scoped_user_access(mode, uptr, size, elbl)					\
> +for (bool done = false; !done; done = true)						\
> +	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \

	for (typeof(uptr) _tmpptr = ...

> +	     !done; done = true)							\
> +		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
> +			/* Force modified pointer usage within the scope */		\
> +			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
> +

	David

