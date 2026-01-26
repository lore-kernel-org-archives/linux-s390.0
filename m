Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592E344050
	for <linux-s390@vger.kernel.org>; Mon, 26 Jan 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445909; cv=none; b=Kp/yGLmsaNp0J9WcZy6nvUTVF5IgnXLkIWUh1tPXgnhJ4niYLHs8iVLw5N74PZwvg6Mh9auY6crix1E06riz4k3wO5sqpE2NSLLZgiHOuwRTYOU93T4wWlJvXId3OlO7FkAYk2yfHj6IIZa9NmXRUaBKBUCDwvcordwLl6v6YfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445909; c=relaxed/simple;
	bh=tE3Uxmr9IsUS6mJokT1N6n0qqojE4/K3/OnOvYAIYeY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4DvcKXcFBEq1xPFBm5up9C+6GBa7NCgpJWc3BUFMYip/djYzgnPd3bTFVTfEFn/TPJzE6qBIdgE9oYO1w27Y9SAgst/NpkxwXNG5cozWvb5WEyMI6ovxFBEWt91OUhO3euh1tVP631DOptKJfFxx1xxcZJK/N0gWkYNLEmzNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtC4TyBb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtC4TyBb"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso4880280e87.0
        for <linux-s390@vger.kernel.org>; Mon, 26 Jan 2026 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769445904; x=1770050704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67gINf8nv70IfGM4en9MXo18NWyvtv/UqgQR1tCJ+fU=;
        b=WtC4TyBbh8yct5Y9IFzhxu13T+HfvneZprkfZ0mAaiIw3wzxldQspYusobja5GsuP4
         X5kOWhqhF39lZCG16fxs/fKUIE5THQRzlVq0W4vNDmcl48JAaEHKD8EQbCswT9K7Om0M
         +9jnqNGKD5Jc2BTFPAdgcLWw8d77Zwvbj6uPV75RsXJvj8oTtWJOqVeruQUhcBuRSwTb
         z7/PqGTIdy6K9vh0VBxxpA0zyNBnqmk6UH0YXkBF8MMw0CDVbt5K7arQBIXmU7Y/9Dhi
         xkW9VCVt8gU3LAlm3Ymxey5lhrSOs9uyZ8Pyl5YRI9s+puriPhqfgADmu6rXkB/9illR
         NDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445904; x=1770050704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67gINf8nv70IfGM4en9MXo18NWyvtv/UqgQR1tCJ+fU=;
        b=Cvnbvcap7clYxmoQAvgmdvw4IYgYk98NGCBZ0VulRqQDMfwlTkXmyoqYDAmUBOJY/0
         JopZK+fK8IVOo1XB7hIvo8pJx/U8BnsR+ppRihqKh8Y1+2bMP3JsQ9aHBwkfRXFU3/f/
         5gK+4HTwUlSPcJJ5/+ojByJGIn7UJTjz/+h9W2/efX3Ud7aBHMuK5TiIDba8G0+4cW1h
         G/xph6vlfCE1TVacB0WeCo6INEHgV1taXlhMnJev+hEJMROXbj0jmIgyKbzqkaHvKyVB
         gaTj/I2onsdvRV9iH7g+2AY/2rTHlj9em512/HmWpNRsnWOCBvzutEtahCbrbu7o97gZ
         rMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUjRLwgeEN8jIf0lh9C7EOcu7SzCTGn2ju5pqy7m9E6ZjOMxkeWe4bfvlRzCY/CYdKbJbfUljMLHceK@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmz5JiwOJhQ1FYuprvxKGFw3Z/PBqy+sYO/Jliq/wxVJL02YH
	6KonBBExi3ZDhLwxtNNkm5z8Y8MTo2l9w4JTIodLzMSCqBb6LAv5INzn
X-Gm-Gg: AZuq6aJ+d5PjQWruFLAN4qnuYTwEucuVKVZY5GvEYJPXd5w2AXpIfyHkwo0dxAB+z4i
	GtT5HNrqkG2/5QRBo+Zd/bwEeW0dPL5q/iwOybUtBU5TJ8xuS1I/8UqmdEgprX8HLzSKDLxcsJO
	Lx/7FsxEmxL0obsfRGZebJiwJUDSbO4YvTz8HIBWrzIh+0Jfwb9cGl6XiYZUnsy8FK1uhxCu6uc
	lTYfkcOG8dg44BzvFn0vRMQu1V0ru5ksXVINCgdRlnOSLido+8Y1y2as0e9afwNXd4jTBNgbAiE
	PRA6EoS2jh1nnMknRq86TQF5fVd3gnQhiFcXw7qpHMjrc9bTCs+BCHxrmvMR6ustONh9WQ+xe85
	aOsw6zm2H//IjJgLhAjBHcsDJU2RoORIyKtFSQNNkWCTRVoXV5/0Q
X-Received: by 2002:a05:6512:3f06:b0:59d:f2a4:3e98 with SMTP id 2adb3069b0e04-59df360afd1mr1753347e87.4.1769445903361;
        Mon, 26 Jan 2026 08:45:03 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de492cd32sm2794304e87.100.2026.01.26.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:45:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 26 Jan 2026 17:45:00 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXeaDMczmQl6wn9v@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <aXdB3lsm3w0fJT3Q@milan>
 <20260126120226.GA6424@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126120226.GA6424@j66a10360.sqa.eu95>

On Mon, Jan 26, 2026 at 08:02:26PM +0800, D. Wythe wrote:
> On Mon, Jan 26, 2026 at 11:28:46AM +0100, Uladzislau Rezki wrote:
> > Hello, D. Wythe!
> > 
> > > > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > > > virtual address. Export this symbol to modules so that modularized
> > > > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > > > 
> > > > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  mm/vmalloc.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > > > >  
> > > > > > >  	return va->vm;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > > > >  
> > > > > > This is internal. We can not just export it.
> > > > > > 
> > > > > > --
> > > > > > Uladzislau Rezki
> > > > > 
> > > > > Hi Uladzislau,
> > > > > 
> > > > > Thank you for the feedback. I agree that we should avoid exposing
> > > > > internal implementation details like struct vm_struct to external
> > > > > subsystems.
> > > > > 
> > > > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > > > order lookup into a minimal helper instead:
> > > > > 
> > > > > unsigned int vmalloc_page_order(const void *addr){
> > > > > 	struct vm_struct *vm;
> > > > >  	vm = find_vm_area(addr);
> > > > > 	return vm ? vm->page_order : 0;
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > > > 
> > > > > Does this approach look reasonable to you? It would keep the vm_struct
> > > > > layout private while satisfying the optimization needs of SMC.
> > > > > 
> > > > Could you please clarify why you need info about page_order? I have not
> > > > looked at your second patch.
> > > > 
> > > > Thanks!
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Hi Uladzislau,
> > > 
> > > This stems from optimizing memory registration in SMC-R. To provide the
> > > RDMA hardware with direct access to memory buffers, we must register
> > > them with the NIC. During this process, the hardware generates one MTT
> > > entry for each physically contiguous block. Since these hardware entries
> > > are a finite and scarce resource, and SMC currently defaults to a 4KB
> > > registration granularity, a single 2MB buffer consumes 512 entries. In
> > > high-concurrency scenarios, this inefficiency quickly exhausts NIC
> > > resources and becomes a major bottleneck for system scalability.
> > > 
> > > To address this, we intend to use vmalloc_huge(). When it successfully
> > > allocates high-order pages, the vmalloc area is backed by a sequence of
> > > physically contiguous chunks (e.g., 2MB each). If we know this
> > > page_order, we can register these larger physical blocks instead of
> > > individual 4KB pages, reducing MTT consumption from 512 entries down to
> > > 1 for every 2MB of memory (with page_order == 9).
> > > 
> > > However, the result of vmalloc_huge() is currently opaque to the caller.
> > > We cannot determine whether it successfully allocated huge pages or fell
> > > back to 4KB pages based solely on the returned pointer. Therefore, we
> > > need a helper function to query the actual page order, enabling SMC-R to
> > > adapt its registration logic to the underlying physical layout.
> > > 
> > > I hope this clarifies our design motivation!
> > > 
> > Appreciate for the explanation. Yes it clarifies an intention.
> > 
> > As for proposed patch above:
> > 
> > - A page_order is available if CONFIG_HAVE_ARCH_HUGE_VMALLOC is defined;
> > - It makes sense to get a node, grab a spin-lock and find VM, save
> >   page_order and release the lock.
> > 
> > You can have a look at the vmalloc_dump_obj(void *object) function.
> > We try-spinlock there whereas you need just spin-lock. But the idea
> > is the same.
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> Thanks very much for the detailed guidance, especially on the correct
> locking pattern. This is extremely helpful.I will follow it and send
> a v2 patch series with the new helper implemented in mm/vmalloc.c.
> 
> Thanks again for your support.
> 
Welcome!

--
Uladzislau Rezki
