Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA93C276D
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281002; cv=none; b=rH55zlH1SdJvjhoQMkpCpyfdV//rfuza4bmT5tdfwZFZX0jeaLngR+FZUJpx8obk3bex9HEQ5Dj6/mSvwo1dr+y5BKl+poVlBEy2bnJF47QKdmVm+CQitE17ADSzRQRfK2GSa9HSaba4tJ+0bp0AZvKJVWqUO1ea52PQVu21l7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281002; c=relaxed/simple;
	bh=9xV2kEuHyLB0jhVQA9YzsyIMdYZ2hjs2wTJWQqBPTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRptcPqg02DYZ4gvMQvtQqBY/eGUDrZZUzLQf/VKUJPRVvvd6shVf7gBFB3bpXfBTDkPpGhjYDjJnNEUpiQTxJOxorAH1+yhR7H1veukaa4z8wVjTDbNl8biswI3vK/HBnAeE0VY95fRhFuspvj3hdd3rl7aA39ZKf07QEa5s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg4BhhrC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg4BhhrC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44509921fbcso3041917f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281000; x=1779885800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGymKabcBXvuedlpqu+QlTLiXvf7PjEFL+l6BnvAi2I=;
        b=Rg4BhhrCEw3Mqcg51bP8ZcfdyfHWDhOMVbWcu1tUIDfcWNX1o883anRtZjgtPW5am+
         V2hXp6C3pQ9CYi947/mcjHeaZ93QhHRLjkHATYfGNdDTbHHLCwp3n5qxzHJfz1LFyYPS
         pUvqUCixRAVRtrPHW+GPvU/9dZ8O1hp+A499yK1CdgTkoFWkABhZoS16NeobHBi5XLWo
         Kat8gjbOc9bB1w2S3VeBD6JnzHKQVmxdel4lQg0vlrfrB9HHEDKE55kI0f6bHdyik/q3
         YZV6AZDjtEtBXAbefQRmqFvDmHeqBgRH3MArCppinPCRkXDfzBtbfRF/QFDMC8CawlZ4
         RwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281000; x=1779885800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGymKabcBXvuedlpqu+QlTLiXvf7PjEFL+l6BnvAi2I=;
        b=MTAcFMLmxeAa01WCV5JwXnoY7QZCXeuBTsQmGdLdqICiG9MttDGbRD2+MI8tjF/pkE
         /EXTAinjigEX9hLh3T6KiMyOxVoZdpPO9l60NH39iLJ+2EKvQLrTzzXpNSHZp2GKYRl9
         RVAY4j5eP4BonDBIKJ4EYfGyAVos8i4maEy7OT6PiEuuZKKw/7jBs/x9TyvFAoNHCRXX
         8Bn82n/9GqjgUp4JzQMjE+0VsnRpvI0f94m2+yXHlTLpjtwvUhxUZCzwjGwR3BDMYm3q
         UeDghkjOJQAq2gNvDTIpR6vxD3FFozxsldkqeKfb/1NwLbtG2db3W3SfzjWuqNe1VHlh
         T2RA==
X-Forwarded-Encrypted: i=1; AFNElJ8iApdVerkAe4RXzA+L7v91t/8cWRHmhmlcXtBjdiefYzKky3cyV6zhyCV0gEgUCM5at3BPfHNp3BRD@vger.kernel.org
X-Gm-Message-State: AOJu0YyybMPqI6WFPAmjJgds8g1qYQq0WXpXYUb2E5BP4bkVqNhdeFBa
	DFRdmVZY59uWRDGzjp+e/tTcTfE7N60jbIQxgJDEmrQJDuYVkqq5FWSK
X-Gm-Gg: Acq92OGlT+Ouenuwy+ooZoYeZb12Crw6QeB/advcVEHubWr1sdWhPJCo606a/+MO0Bg
	D8fwjrdAYX+0+BP4GeBcklNwtER1et/e+VqCYoVLgfk3M3L+7LRayc5ijSmFCQ/AT21Oizzi3L8
	mr65sJQb1dUALRJqgDzMLPzBDGEzHTrv9gqpGySGtPR3EWrtiWLMbXKeu8xSoxH3r8ZcWL1leFM
	lcTugSK7QTThy2uQ4OpGABFJD2BUDGrRzAHL2Cpm6Sv0CG9K5GgYY2AAkxuGTuMAU/EwbURPAYF
	OcgK5X//3YgB+ZfZey1uTG/21SLOh9znB4RIOgi8WwRLbm0JlQOTxUaBSR6PGtCbtTuxy9mie/Q
	WYcuoHt4s/7RtOo83Ka1b70e40TEyGEZCJ6neWZhYd5QosfsGM9jy6v+r6+2QZYPELUqa9XHj8h
	1Dkef7kvb4iIOF2SPtVl7v5GY9tXLKkK2jiYp9yifEYCK1thSWso18KBnx5/q2wNgh
X-Received: by 2002:a05:6000:228a:b0:44a:b0a3:7c1a with SMTP id ffacd0b85a97d-45e5c5cf9e1mr38233742f8f.24.1779280999565;
        Wed, 20 May 2026 05:43:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm24718459f8f.6.2026.05.20.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:43:19 -0700 (PDT)
Date: Wed, 20 May 2026 13:43:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Juergen Christ
 <jchrist@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Yang Shi
 <yang@os.amperecomputing.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/9] s390/alternatives: Add new ALT_TYPE_PERCPU type
Message-ID: <20260520134317.778dc094@pumpkin>
In-Reply-To: <20260520092243.264847-2-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<20260520092243.264847-2-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 11:22:35 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> The upcoming percpu section code uses two mviy instructions to guard the
> beginning and end of a percpu code section.
> 
> The first mviy instruction writes the register number, which contains the
> percpu address to lowcore. This indicates both the beginning of a percpu
> code section and which register contains the percpu address.
> 
> During compile time the mviy instruction is generated in a way that its
> base register contains the percpu register, and the immediate field is
> zero. This needs to be patched so that the base register is zero, and the
> immediate field contains the register number. For example
> 
>   101424:       eb 00 23 c0 00 52       mviy    960(%r2),0
> 
> needs to be patched to
> 
>   101424:       eb 20 03 c0 00 52       mviy    960(%r0),2

I'm sure it is possible get the preprocessor to extract the register number
for you.
The exception table logic almost certainly already does it.
(The x86 version certainly does - and that is far less trivial.)

-- David


> 
> Provide a new ALT_TYPE_PERCPU alternative type which handles this specific
> instruction patching. In addition it also handles the relocated lowcore
> case, where the displacement of the mviy instruction has a different value.
