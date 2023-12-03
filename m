Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OKzguQkS"
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF383F3
	for <linux-s390@vger.kernel.org>; Sun,  3 Dec 2023 06:07:58 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-425430fe8d1so10985991cf.1
        for <linux-s390@vger.kernel.org>; Sun, 03 Dec 2023 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701612478; x=1702217278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CiMNgzFr7xNUwBtnhCHdgoiuX87pimcKNL7aMsL6fgY=;
        b=OKzguQkSABjtxWcOMcm+Qbmet+nHku05O6x23HTlp1qxdIcYZhiIeX07SPUb1E2IF/
         kYP/aC1uzAYZHJX6YNAFeYWxjkGz87iG6PM5xB8mIeskDKJW2Jd1oz2mWRNywi13ddRb
         rL5cnPtHr04ZcvHCFcbbh1FJ3/i2ih0Z2s8KEqc8CV1X69q2fEzRg9NPvGRmq1DUEy2L
         I01Fz22rSLoLI7+p4usNhV5XZetpCquDVJjGgygKl8tZYmK2sYyXfqyqacbQwAyEVJci
         zescEoj/ayE/KRPps3Qc6uCwyA3DUXhbQJpwWZtn7ppvYg52EJ+lhK/mbycRZIl2Jn2J
         sZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701612478; x=1702217278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiMNgzFr7xNUwBtnhCHdgoiuX87pimcKNL7aMsL6fgY=;
        b=hlHTleCnWxiZ3kWjJxdw47MUnPVGw6IssEby8crRaO8rAgjcuuhM4K5yTZLKp0KbmT
         VtaysCJp08XwdCDZBBG9ImHC4QXPJJ/l8/vhqmb6ZUbZ7EsGMArN6w/6kCbFxR+KGWT0
         fD/iJLlWoW+hyCvKsSqWEr1lpyp2CCGvwpjxyqPKH6d10iqmdtPsM6XQsNqg8n/BogEl
         b3sf0Db0OU1sXzi1ENG9FThEmgQkcKnhoFQ+eeqK/YCl0YD876pRom7HSQoT9lpmdDnO
         pmJ8uBtKVB6auvNBVF7SvHD2PTQVQqClrEE5SBCWl83n1SBpX/JU8ytJNf/fY/xAzNsx
         rdKw==
X-Gm-Message-State: AOJu0YxRI/yiGYOpYIqEoK9QVjAVF4M7tik9IX7yTrefTthhb4vfpP0p
	deQL26EOONtRwBJ4riGdZfoMCQ==
X-Google-Smtp-Source: AGHT+IHLblrSR9v9mU82kXzYVsIygmNXeBVbxztP2WE72q1qjIUsHC92qYjoWB74bCqvYp2tHSpE/Q==
X-Received: by 2002:a05:622a:7148:b0:423:e4f1:4958 with SMTP id jc8-20020a05622a714800b00423e4f14958mr3926493qtb.56.1701612477906;
        Sun, 03 Dec 2023 06:07:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z9-20020ac87109000000b00419c40a0d70sm3402958qto.54.2023.12.03.06.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 06:07:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r9n8W-009HdE-5C;
	Sun, 03 Dec 2023 10:07:56 -0400
Date: Sun, 3 Dec 2023 10:07:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, kvm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Anish Ghulati <aghulati@google.com>,
	Venkatesh Srinivas <venkateshs@chromium.org>,
	Andrew Thornton <andrewth@google.com>
Subject: Re: [PATCH 05/26] vfio: KVM: Pass get/put helpers from KVM to VFIO,
 don't do circular lookup
Message-ID: <20231203140756.GI1489931@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-6-seanjc@google.com>
 <20230918152110.GI13795@ziepe.ca>
 <ZQhxpesyXeG+qbS6@google.com>
 <20230918160258.GL13795@ziepe.ca>
 <ZWp_q1w01NCZi8KX@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWp_q1w01NCZi8KX@google.com>

On Fri, Dec 01, 2023 at 04:51:55PM -0800, Sean Christopherson wrote:

> There's one more wrinkle: this patch is buggy in that it doesn't ensure the liveliness
> of KVM-the-module, i.e. nothing prevents userspace from unloading kvm.ko while VFIO
> still holds a reference to a kvm structure, and so invoking ->put_kvm() could jump
> into freed code.  To fix that, KVM would also need to pass along a module pointer :-(

Maybe we should be refcounting the struct file not the struct kvm?

Then we don't need special helpers and it keeps the module alive correctly.

Jason
