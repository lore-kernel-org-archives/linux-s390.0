Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D13D3306
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066598; cv=none; b=mTMlrD9by3VZ/AZejIcP4mMLp9r/zMXkaO/9sL2tMh1UU2jh7fd77HJ6TV1qG2UnYQLgsFLNB3CawikD04DLtX8sbidZCYgrG79EcLNpJ58QkLQoDEpWlZa9kH+t2uOTXZGFjwYyYfnygE4mlorbaOHkJqAdpV176tMobpafkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066598; c=relaxed/simple;
	bh=qGkfUw0cAuRi50whdAw9tYXjFfsurpxdwyuHiMRzvHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnZeIH5jInyMWqoyZGhlhc2qOWTQPnBSgkYhaBp4RqOqhvKR2e5F9y/5YjJ+2DPbSfFHwD5Ppk/Tw9urUtyL1cDJ0rssDmUVnfmf+EJ1dj6eQSz2VOYs5rAUhIF95ORTbi6amHxMZSEgKCiBOV6ilZgS6EnxTxmYcmEK/paa01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ihyQWMnv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ihyQWMnv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd847b4b23so132431785a.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773066596; x=1773671396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=ihyQWMnvVuXvR909Z1cWQbCW/x6Uje2bNeYH28gk0StuBuzAOqigvjL7w1dE9RCBvz
         ZoZwM7cx4GGinybPk7GhMgYWs8ydFH/+Jkrso2JRthaffI2Zbp5XMm+3eSXkDs8OrWPp
         1PdirPb87UjX0oH7606aIZq+oaAGP7vKybDN2bYMkprfF7k83xhQjnzcnPUik0YOPAdr
         2/KizCv3zVMKKDWmAMInYE8tZ68AN+LVOAzGdtD0I5zgKs6YmQZljOhOH1YH4QRwNHq0
         ro70VHn1/JFY0xIEfw2/X2a1ANbJoQ6e9TuLfleRF6ybM460qzLn7jf0fGZVrlG5Po2P
         lTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066596; x=1773671396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=F+nGmtETKaen7ea6G5VGgpsiu5bQnJntTP89fnIy07rFf5NFwtUli6uIqvqchUhnIF
         8YGpuQdOT+hQKjkBVzLFTJ539SpUUGmjoAISEv/8nQ7Bd3xjM2zjhmkUqTYD7HepwQ10
         ZiwFp2bIm8THNOKjf4h9lrTU3mjUainmAxfLkIBnd2SUyy4KUn6gR1jAreFzxHHm6Cq3
         ClLgQYx1jusf4UB+3JPu5ABn/fZh3SCp0Xej1gik3Os4zOVj3x6y73fsB36kjuLn/v8P
         wl8Vt0L1tlCHgcoLlUAYSW3oF8NMQczZfNCHxfpQPcOXswpVrETDLkH8I8quskMCXJxd
         lwpA==
X-Forwarded-Encrypted: i=1; AJvYcCVBJqHyQd8mE7oaWCL93opFos2sgc0qDNEaEGxOA3wyUM/IeXwwKXOBr5PrP+R4UVIibXvCKSI9yK0V@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsZVT5onECuE2wOmLcLh5bikCOs34uL4YDO5DN5uYxvLgLFoZ
	jETrEnoOIyXLRUucBmHniwCj5if4V5IkGKewl3AG+HXUTQHWXxmBlupbWsvP+TM879s=
X-Gm-Gg: ATEYQzxiyIkqKq3xGSFGCVZ3Rp5W1hQ+DXMG0Dm8rSWYfJf/lBjqACPr5qVfOGzgFHa
	YP9XchtXa2kYzIpgNssDShIB0wV/8nSoYjPcRCRmYRJsEVPqhq9ccvfcC6+DI25tkzsDmJCgMVG
	0BQx/LS1xACind5rJ1OAt2KwfJ5lPkN38NYl5qBGswU+KSRs2tDnyQW2K8jhUkObBXsrcwqQ8VE
	W1vEvZcQbDC/1nzaA4x4VxutnBESApqI5j2EkF6x4yMb0SSs5xr5wGr5S+HdF2/+PJrED+LFOuu
	jiKktEP025hScmc6cO9POiXHXNx8GghVDWqQMtxERrgN0Fwa+c5i9sZpshI19OML/WKKv7wNn0s
	sgghgieZ5z/m1Vf7YMeXjtwkgEqnZa0XUqh5qV2tFeYjM/6U4Yvft8S1ZvYZHNYA0wjj33dTBAz
	W9q7QdLmFciq+4EQ+F/PlCXYhrs2M492Wq59CdgAlb1qmS2C4m5bho93QMkr4A/d1c81bcdELiE
	9Pt+JGp
X-Received: by 2002:a05:620a:4809:b0:8ca:305b:749b with SMTP id af79cd13be357-8cd6d4d5456mr1426307785a.60.1773066595964;
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cad48sm148711185a.33.2026.03.09.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzbcI-0000000GTxY-2R0b;
	Mon, 09 Mar 2026 11:29:54 -0300
Date: Mon, 9 Mar 2026 11:29:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-mm @ kvack . org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in
 zap_special_vma_range()
Message-ID: <20260309142954.GM1687929@ziepe.ca>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-17-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:47PM +0100, David Hildenbrand (Arm) wrote:
> There is demand for also zapping page table entries by drivers in
> VM_MIXEDMAP VMAs[1].
> 
> Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
> just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.
> 
> [1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Are we sure about this?

This whole function seems like a hack to support drivers that are not
using an address_space.

I say that as one of the five driver authors who have made this
mistake.

The locking to safely use this function is really hard to do properly,
IDK if binder can shift to use address_space ??

Jason
