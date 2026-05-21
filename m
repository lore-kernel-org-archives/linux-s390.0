Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21213A0E80
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359010; cv=none; b=JU7tkHaysUIFq96T0gfmZAk3QVgfhb4oF1KyodRcgD91Yli9SW1E5HBGYCAW/crtLdOVQsSTKQKyFC3sm543QmxF8rNeIifZRAXvlvbqToU6s45cVIukchMTN2UT103HzMTOxjs08AFGlxMuYtS6IoctfrsatT0ZJJWbFlDKDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359010; c=relaxed/simple;
	bh=1s5oOO1nQE0nOfwZrgVU8/sWDGdyqOGocvneNxGe1BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPzf8VMAHnW8yyOpni0KYfDYqebuk38UfkvjxVUxjXi4IJ197mZ4Z2U1JYd2qiE8WUxtq67z8Z6VV0ByhtDYRHnMH/AwkM+6KlM7kJL0SPUf+mpKTh44B+32N5jrY+w7LfnJNZI7//kSYvTJTHucqrM7iRsP5LQAQ5scH36S8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIY9t2ri; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIY9t2ri"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903dba5c3cso673195e9.0
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779359007; x=1779963807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3FFMMdf6LSzM3i3ZcKoUcshpetuF/yNSBJpg5VO8+c=;
        b=XIY9t2ribVaokZhECVMsfHurqz97MHjy6ZJCG193cUAO+O2+m+pVZO4TlAowQSOmKe
         qgE5SMtRHlhu6Oy26KcoyxHUbjvkUFMrAkzaF374QJfLV8PfR+7cTUu/dyfUyx+AJhUn
         +dAth0gTQ6Pk1Xp+kH7kCYF1E9BgNrVBR593UkoJdd6t+GKI1yNQGyTCuaUZf4pYJNNo
         NvRDahzkR+u7WniFjGAKP6JKNkoYbaTCc7FHNvDRkDy9faylIl7Fr09U0c1bwallXsNZ
         K3gQcmP0wduitidOJKK+Oa37ct3+AMyia6r0LMR9F9BKUNqC5MgTwAzfsg4nP2jsNXd4
         8vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359007; x=1779963807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3FFMMdf6LSzM3i3ZcKoUcshpetuF/yNSBJpg5VO8+c=;
        b=EEhjn4qfb+uidyho48YlVSJOdxhbpPtnKtDWt6/OrINYmvVtCJAwqjiBA62mO0Igd6
         thrNvXr33tpTLuA1S3/XWpocttpF1kNwDwjdY9SgpnyucvNqJwR3erqVN57l06bHj7C8
         kBUveMNnqZPsHL77tyaPYdpK3jVdOH/siBsWEntvwT3+zzE+d2sWlcmlydKbACbz6VMQ
         GgBqUOjIeJND5ebTcoulrpEzARxLJgglkXSbI9VamAub69jNcKttmG3zaUQlJhQlYCbK
         dtK+jmzBOroX/eIfpOHly5fCBEDoQoG5ku/k2Z/+jmmSI5QW+btoSnxu4tRusEOZRgpq
         QcaA==
X-Forwarded-Encrypted: i=1; AFNElJ8VL0uPsryCuCuoTWsNYxXooei6UVIE1J5bUlZb2DSzJYYeDuN3R9vMX/5gCn/d/sq3RsooLydXckw+@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQEUiiWFlNXr6RzglzXi5xfJo8Wtn4YQH93axLrxw5sANaf2J
	ofBWqiWWaKLspE9NpL0BcXz23UrXCHO1jh0tYtkjOKQDsrtUv/WHXcj3
X-Gm-Gg: Acq92OE7VmA2buANyDPyrKJAt3pTIx+h9AbIzoZnyCt0fx4SBxkmegIhtNJJPRaA+Sm
	gHMdw3QGGvtF3QGKxYH6d1cviLSmVl0hVHirSCGPxQSnTgZR5AkutWvBSSIiGaVVOlb2dBjx+iM
	5gDA2nhlkiHQ0P54AKIgJCvNK8+MESrm4NApN8swKy/IB5WAUnvGW0B0GEUYiBHx9C38qKqF1/l
	5BptJxf/R6Sb0jQrI/xeRL8C+pULOny7UOUsQNZRJcOlvIGlqjUmsNaxoxLX1nM35qvR4FHEAWW
	LG1sySYyMhHDgdoHhj6vBvDYee/nV41BxF5HsT8x8CUYTMynLuSMbYXzbJE3FPBhw98H7eP0crC
	e+0n4z7I/5C8683yBah/5iI9zeutRlwmTsRWW5B4vyx2t3Pl5IaqE5Yp95hUkZkSH6VyFMw9jzy
	OMXmsRQeNTMqZUEzbQP+oMMJq6vc73kwuvU0cit5VHLFj+wxKyiaAUweYefAE+NUnZ
X-Received: by 2002:a05:600c:3147:b0:48f:d2fc:d025 with SMTP id 5b1f17b1804b1-49036035282mr29348345e9.6.1779359007211;
        Thu, 21 May 2026 03:23:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c22d97sm12933315e9.1.2026.05.21.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:23:26 -0700 (PDT)
Date: Thu, 21 May 2026 11:23:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260521112325.230959c9@pumpkin>
In-Reply-To: <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 17:23:37 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/20/26 3:34 PM, David Laight wrote:
..
> >> So it seems have more overhead than the percpu page table approach IIUC.
> >> We don't need all the steps with percpu page table. And there is no
> >> penalty for migration.  
> > This code looks like it relies on 'page zero' already being percpu.
> > So it probably isn't really that different.
> > Some values like the 'preemption disable count' and 'current' could be
> > (maybe are?) written into page zero to give fast access.  
> 
> I don't quite get what you mean about 'page zero'.

'page zero' is (at least for some cpu) the memory that can be accessed
using a small offset embedded in the instruction.
This is equivalent to using offsets from an 'always zero' %r0.

The code relies on the accesses to 960(%r0) being per-cpu.

-- David
