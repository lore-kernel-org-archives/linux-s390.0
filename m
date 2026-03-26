Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3622288CA3;
	Thu, 26 Mar 2026 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550049; cv=none; b=X3zn0XC314uYxW1NW6z77UuXUi9FiG10dKqg+yeSfNtFJxefV/mA2018EZoj/StMZgpGp+cgDtWs/Q2/3gYaoH4I/+bV4wEXsZHVPnSAlXq+6uaMhR/jWXgAXzxaXXhgSH3Zss5L9N2FZr7kYZnX1+XN5iWnUbpM6Q3GrHLGOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550049; c=relaxed/simple;
	bh=iKxMcUILKrcA41tExDgHW7ilkZ2Ux1oLQWlph3sXKZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbVJRb2q3RsJb5X6lvKq/JAYvSL8DcXvQFAQi6UzlN3QaM/VlVHgB7aBU9qxxCF1FwYb83dd3SmmgvJVuTthMS83z97aMhAW8M3W819jD/RwewZmNEzjiX4dz2ApCEa32noe8zpaCUd9kKAehljV97dmZ66RrblBBHRMvWIXd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMFyyHhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMFyyHhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9A8C116C6;
	Thu, 26 Mar 2026 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774550049;
	bh=iKxMcUILKrcA41tExDgHW7ilkZ2Ux1oLQWlph3sXKZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMFyyHhwfuhV/t58V4SonKbUNr9vfN/ZVsId7D0+N+dAl+XkcTz7TfkAhjijHY5sa
	 3TcwVx8KTtIUsp2dHslBjevpXhVI/0F77MOmkq/MuhiJrIA+FrImOCXlcv3KYh+TLU
	 VIyzDHMqW2B/wNUMPzdOEtZ4R/n5QdljHnkh6X5NEsGL5dxSv82nk9/1pVzbOi3mz1
	 KvGa/MbDKepdeWVxHZBqBYBNdB4mPiP+eKWPOjoeTAKkaKUdhU2ksU9dZtH2HMQvKA
	 jP2S4wQfwaflYFLZl5k/jHlg1tFouZ0lgebV/uAEXh1Cd+6mumiydJyqo3hAugTpXC
	 4yKXShtnKHubA==
Date: Thu, 26 Mar 2026 18:33:57 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-ID: <98a33605-9419-4bc7-8b40-ea47fd598df4@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
 <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>

+cc Roman

On Thu, Mar 26, 2026 at 11:24:35AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 26, 2026 at 2:18 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > -cc old email
> >
> > (Gentle reminder to please send all new stuff to ljs@kernel.org - at some
> > point I'm going to set a rule to ignore kernel mail sent to the old address
> > so, if you need a response you should send to the new :)
>
> Ack, sorry about that and thanks for all the reviews, Lorenzo!
>
> I noticed Sashiko's concerns at [1] and a number of them are false
> positives but I see at least one new claim which might be legit. I'll
> check if it holds water.
>
> [1] https://sashiko.dev/#/patchset/20260326080836.695207-1-surenb%40google.com
>

Is worth letting Roman know which are valid and not, as that's useful
information for refining the prompts etc.

Cheers! Lorenzo
