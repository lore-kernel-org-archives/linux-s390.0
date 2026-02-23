Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432B34EF02
	for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839723; cv=none; b=Q03vAkpuKXRXATIYN5EDLOS+HXGH2ULowxacnsoxcDQM4y3EPr6vrCTdlADDfe95qDXYlEH4HD8WvooqWWDw2uO9EudhxywmI42oiudPk8mI8GFb5Lo2GbIPU+nmd2OEfcELxUI9ZqxEdr5udD4Z0e+ZwSqg6hQYH1iqWpUbCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839723; c=relaxed/simple;
	bh=h2fE6FJnt+GTKQVQdqqbEpUoyJIa8aBYwbs8ZoZNJxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOSLqaLQOqBvcJorzuYl+Ohxa2ACSSksaWtrpmmbYtd/hwCtqe2nwrIahwYKK0+xRk5YVkSVw/JisnY9jMxpq7q24eBwhrN1U8v0Iu+jCQJdXNAQO3CEf0vzju8930/HapzsyxtIPnpXPTF5UpqixNftptJ+fezy2/6MUwvV9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8jcbl3I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8jcbl3I"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837907f535so36407005e9.3
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839721; x=1772444521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP6bWvtU8eeL2/gAQvmkB1Apc9H5g4lS1edf4fQ7WfI=;
        b=O8jcbl3IsaLsFrDMafag9I0CI/ZwyUhagbpmgRJft4VFwt39ifhvNPt/enF/DPShk+
         hk+Ms/VLOl6Qcz3z5kB7dPNTDE7TpB22p6Y6b27p1zeRDFrMIaK0suMZuOpFP+hC1yXJ
         7LnF1oopx85bhkijMEZHtzT9l9aAP8aBuOha7AJiZhMamRapsZjKrxF3XNQ31RebYDYH
         KXoooUD7myBP/eupqCEY8NJkStMf+RWrG9wboNqTjvCaGVnmyF8hnSaJoBH63HYNOKRL
         m3dpIa9OB30gucGstqPDMNi2G+odDqNjDlYXx7kSwFwjZtaBt9jSnTM8KdKHvKaX2TkD
         +V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839721; x=1772444521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uP6bWvtU8eeL2/gAQvmkB1Apc9H5g4lS1edf4fQ7WfI=;
        b=NorHaUZlKPdWqyEgLBktvS2Q9sDaigV1IIrC0hLc4xErX8lX/2o1FNLQAu8ogs9AiE
         ecUG4IfJvjEPYt9ou0trPKO2ODu34uMhh47iOqJ6wMquOz3atshypSkRc/subHHH2qqv
         QZtchbizx8UN9pRVSi8/ZyWEhUBL1NfJYVJvhHOmCfzx2W+WGil7vIU+asg+rkWh4plE
         LHTjhWl4j45cSId45jnTQdaQlaCNjHL/ZeQ9uahrTmUF1B1l/LBVMIMFBYRTUhi3KOCa
         cl08uQJ6dPAwitujBskStZoXLBlt/g3EL153SvDindDSa2KzMJrcOE4BRbpX1b8iNmoD
         dd/A==
X-Forwarded-Encrypted: i=1; AJvYcCWQyy94ZV4vS5/69p1E7Y3bYU21jqQG24pOn0NNsamPc3Sg+7KP8YP4FdmRDY/RbrxYKgIxJnMWr/zO@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmOaoaEVBd8y56FEdM9ptSd7JeMI8YtUq2AnmqhYFshpwyvDv
	7qkqi462GMUYOhLJ7PP5vVDXOQtIpTqfspjmWrKkosDlWDAm2TvSEoHS
X-Gm-Gg: AZuq6aLFZDvaTmsJFqRZKDK8XECPl7sMWD2Qy3iQqMkwp+DaodksXMuZ6Qm36smgz7Y
	bpmJcjuNwZFpjxce2+5kTLnry1G+elOa2JPhl5z9byRi/e9qDdPr1jU6t14jIhO4+3rkQvv4RQx
	weXTAZmC4VMekEFaPrdT/sTvgOkfyDqjtKskE/z/6xDMZAZK4vaQ8esl8z4aNbGCW0LjVDs/7W/
	FV8JTifEJ8Csz9TMDzkckIYHLPH/igBvd5WHypVjotZgzyiukZB/24q+kPrpe63/V9cFYAyMgYI
	49k4yswdIDbAP5w2M5lnbLwSzBm8UIBGdy+s30ZSDQ2IyMpML1ORhA2eAYDnthzuOZJ2zgcDNBB
	q0nLtCD8f4cyDdE7FrvKCPrKTzTZQGW4EvGyf+aRqWpmnMiRN15k6S9Gh27hYN5K1+S6l+sdmzZ
	v1YBaNdXQqUVB0B84VOq8sX3TMhFzjRtFC1o+izd/dFLY8D8kn1HbMQLjRyeng20ypLA/zsCWTn
	3c=
X-Received: by 2002:a05:600c:3b27:b0:483:702f:4641 with SMTP id 5b1f17b1804b1-483a95bd842mr121940845e9.3.1771839720960;
        Mon, 23 Feb 2026 01:42:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f0330sm222508405e9.9.2026.02.23.01.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:42:00 -0800 (PST)
Date: Mon, 23 Feb 2026 09:41:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <20260223094158.2197d7af@pumpkin>
In-Reply-To: <87ecmcwjh9.ffs@tglx>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
	<20260119130122.1283821-4-ryan.roberts@arm.com>
	<87ecmcwjh9.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 22:34:26 +0100
Thomas Gleixner <tglx@kernel.org> wrote:

> On Mon, Jan 19 2026 at 13:01, Ryan Roberts wrote:
> > I tested an earlier version of this change on x86 bare metal and it
> > showed a smaller but still significant improvement. The bare metal
> > system wasn't available this time around so testing was done in a VM
> > instance. I'm guessing the cost of rdtsc is higher for VMs.  
> 
> No it's not, unless the hypervisor traps RDTSC, which would be insane as
> that would cause massive regressions all over the place.
> 
> So guessing is not really helpful if you want to argue performance.

The cost of rdtsc will depend on the cpu architecture.
To get valid comparisons you need to run on identical systems.

Regardless, the cost of rdtsc could easily be larger than the
cost of the prandom_u32_state() code (especially if inlined or
without all the return thunk 'crap').

	David

> 
> Thanks,
> 
>         tglx

