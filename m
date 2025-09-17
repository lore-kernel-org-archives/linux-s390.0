Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD22FABFA
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131701; cv=none; b=lWLq5BBEK7l1GQfJqCYLUefRGfqTRykRNuXELngiAmEAT03+62sd2nUR61YGrKAkbgtf+DkPp/4WoghJiBqgzhIIWpDi4lH2eQEUgpuKRfASc3qaAcp3cegG7c9PpqzH9LecD5OL4tF6wrzHPs3UMq7GW6C1QgbVqZ3el0foruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131701; c=relaxed/simple;
	bh=zRgW6lw9J701Gqppx8wjChVUjkrQa45BToZXXs36Tu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7jl4Vu+GXEbw1Pa/XBv28S+iJ4rGrFAG6z1FjKmqllRUDCRPyu3+eWQF4dBuyzf+ZHU5n4RasGqF+XcSxV3KMTfZKAVh0qaKZgXLPQV5UD4uQGwxfK5gQROgLBQIpvLFp5IaXkSWAI69ojKWyG2U4gjctd8Iz/CY4dvFMteH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSWwGYHb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSWwGYHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758131698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oTk62YZ3WbA6+duzWz6gvXH8IMjQs/3aO/dwk372UHs=;
	b=LSWwGYHbU/gBVmdLCPAjhpmUzdq1eV1uxlJGSxEoWSwg/J2CfIHE3YN6lUpAB2wgas0R6e
	Q8dtS8aVdwTmct6X7K7TV2AI770jtAwDcwnqz4CCPDDQObG38Z3dwv9xqFnY7yDgsukWMp
	Gn9n9aFwyA0zvpwC/yNC3/iMnAKt/Mw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-7kXUdblzNo22viVFIr9b5w-1; Wed, 17 Sep 2025 13:54:57 -0400
X-MC-Unique: 7kXUdblzNo22viVFIr9b5w-1
X-Mimecast-MFC-AGG-ID: 7kXUdblzNo22viVFIr9b5w_1758131696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ec7be07a24so3606f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 10:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131696; x=1758736496;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTk62YZ3WbA6+duzWz6gvXH8IMjQs/3aO/dwk372UHs=;
        b=lLTr1lMLCdaYdcAF8Vrb9xs4hHWhVnhU+sVA4DE0gT9YTFaVaeROfusXRQXDmknzbZ
         1+pOu+CscvMg4LmnQu7D5dHkWfy72uyvTgmY49Ol+5il0mZ+9bXhcClKt3R64k36cg3C
         cnswrsxFIHVz+D0410EZTxhOWCFF2wEHeCDufOY6JqzvRFKFs2dufIBnRS18EhV5yZeh
         tRipltg8PlWtGaXflzKTH3Oseg+7a9dgcjXBnkElgup4eL1wxqZ3HmMPIvCmEIi3IHJc
         wG1XExR4cdbwWH51UNJDCAC0QtsZvINuPg+8fo5k28TV+6STiv7A0E2RdIJeGtZFzaM8
         CBmA==
X-Forwarded-Encrypted: i=1; AJvYcCUtdBbbFCWQgApGdCCnsCR22U1s053pi2soTWW9XHjOyOV8deDCVaet5OPgvb2IEX+EHhjiTUORe+c3@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtlxPU0Mf9mvG72nwixUj5FmVmrycJN7AH7ke/ThDQ3T0+Equ
	aQWf3RT92AllyNWnLLx4bp1sVRq0z/13iRxy3ljdr+jYKp8z7ybmTrEfaeMc3/tEV8QzgYsaXNs
	9xO5I8V7rQ9CdPbKocyWl4+hf00Emp+PWbhAo/bVlBFEky0lfTk48VeeckfJm/MQ=
X-Gm-Gg: ASbGncvZMsrWZbTYmW+64kK/UDG+aJ+QzPRbBPbeDh/X3TMO5KSW6ZfqoOXv58KIJR7
	/XTAmo65BwlSvMk1k45TePFU230W5C99WBA56/xlKz8S6DVCFmUo9jlkB/dH3GkmOQraHv6paDg
	tl/2Ttcrqm0XK+XNz6GOgn1C+g4m4+dFfr3oYjr3T+xJK3LBrgF+RpjOcQ5vs+jkDcL+uHEVUJL
	+4s3VDFHkw4+SP2n+j610au3mHzwivKxGI+tbKxjBjbhxmBrceU27Ob+y5S4IbxDJMHYfmsBPCI
	G/mjoCjl/GpIu59VYfCK+uy6ONJYw7TcUmQfTVFvxoQ33zCEHvTfdQDoRYu8mCn0z85kBNaPFH5
	vxoNYrUJG5M9oeEzfreReWYNt0F5oHgReUAhnXDln5Oo=
X-Received: by 2002:a5d:5f91:0:b0:3dc:1473:18bd with SMTP id ffacd0b85a97d-3ecdf9be76fmr2989539f8f.3.1758131696111;
        Wed, 17 Sep 2025 10:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGZmxP+YviHOm0h6b5wDCSUelRaj5H0jK0k0fbHYIBN7rACMveP/DKR5uKOZjzV7AiczrEDw==
X-Received: by 2002:a5d:5f91:0:b0:3dc:1473:18bd with SMTP id ffacd0b85a97d-3ecdf9be76fmr2989514f8f.3.1758131695668;
        Wed, 17 Sep 2025 10:54:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm44803235e9.3.2025.09.17.10.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 10:54:55 -0700 (PDT)
Message-ID: <5aeb8570-7f15-454c-bde2-b77099de94b9@redhat.com>
Date: Wed, 17 Sep 2025 19:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/3] KVM: s390: fixes for 6.17
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20250909115446.90338-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250909115446.90338-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 13:46, Janosch Frank wrote:
> Paolo,
> 
> here are three fixes for KVM s390. Claudio contributed mm fixes as a
> preparation for upcoming rework and Thomas fixed a postcopy fault.
> 
> I've had these on master for two weeks already but there was KVM Forum
> in between so here they are based on rc7.
> 
> Please pull.

Pulled, thanks.

Paolo

> Cheers,
> Janosch
> 
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>    Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-6.17-1
> 
> for you to fetch changes up to 5f9df945d4e862979b50e4ecaba3dc81fb06e8ed:
> 
>    KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion (2025-09-09 08:17:39 +0000)
> 
> ----------------------------------------------------------------
> - KVM mm fixes
> - Postcopy fix
> ----------------------------------------------------------------
> 
> Claudio Imbrenda (2):
>    KVM: s390: Fix incorrect usage of mmu_notifier_register()
>    KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion
> 
> Thomas Huth (1):
>    KVM: s390: Fix access to unavailable adapter indicator pages during
>      postcopy
> 
>   arch/s390/kvm/interrupt.c | 15 +++++++++++----
>   arch/s390/kvm/kvm-s390.c  | 24 ++++++++++++------------
>   arch/s390/kvm/pv.c        | 16 +++++++++++-----
>   3 files changed, 34 insertions(+), 21 deletions(-)
> 

