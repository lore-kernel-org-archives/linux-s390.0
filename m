Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364941;
	b=Qx0HjlraJ90uM39NMVriuvgqhb0AZeUbuGj8BrwTGtXKGi4cAhwoh5tpfMUjUeUcwbxb
	 Deqarm+z9jb3MSKPn8GzLjgJGPqxSM5sr45+h2WKO2c4PUw0/VKgCVYtsbfO0u7KEG260
	 dNJgIyBcgpEec2EsEADcuSR90wVBRtM3P0y+3GSpbmtD18fbxB24Z5V0YYdbeLPi/Jf5P
	 rBM8ulzKxcfoz5jqvqynWLeQCbchylFpl4YksbXk7J/6X+7J22Lj+9vT8X8xTLnExezmw
	 RiHEAkul+7G6Okl0ZOELAp5bb647H/NdLUrby5/rYMTAXm7vScV/si0noU/AGPLBsug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364941;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XxP8OOhPlU3E52h/c7HsGP6acikMmgnMKkZh4h9TOUA=;
	b=SHn8FQYaI+Y+fa3ISO1euW0xq0C7w0t+Ihi/c4+w9AQ6heCNS6tGtte39VkoFh+I7VbG
	 j+zdTUSQzpt5Stcjcx1cl2GwAtKCY7qzO8dhW9R7Q5hvp+eDbJ4ZNTILygm2YIYyMZ6nK
	 4MSPkK6I/qCxYrMYNSq0x0kePv+f33jJ55NAbVQoxzSqXfkR0mjHPLPwOtkvaV6a3LoFs
	 fIi+QZbjHjXQWg/YErBtg7iYWXXKUXfuB1c99gV0A0lAWeFerIJ1H4/ItccM3QA+fscdF
	 XX8Irq/Qe9yM3djjXI8vPReUq1CafLxFSE11nxFPc1I+7gbLHZX7XaUOMDK/2396WFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo7t7EHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26186606A330;
	Sun, 22 Nov 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo7t7EHN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA351F000CA;
	Sun, 22 Nov 2026 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795364940;
	bh=XxP8OOhPlU3E52h/c7HsGP6acikMmgnMKkZh4h9TOUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jo7t7EHNKyqF53k60Wo4LFD7+0c8CuLJn8wSP2453MHDj3L4IyCSGu11HHw6s0LBA
	 5ovCAOXqS1mqN+Q6c8setMKLBd3X++qACWM0zstTFYDH15hEItZQ7oxkG7Obehu1Z1
	 7CgR+OSM/JopTMPDxQjmlYN2N4IiZ5Hz3pFFXavtrxzsAnFszhRGc2pxsAJfyHidJJ
	 3GqsAxmbOpGvDuVvkQ+P1zuwd+WhgGgWAsxNsVrx5WwcMlFW1praNbcyPYKREBQYA6
	 cDs36ydEoBBR8omgcSy7yZt8/NO0A/frw+WSEhgCqNaTYm7vuKkwhg9jDPatIn93Z+
	 poeF3M0ypS/mw==
Message-ID: <aaed2661-8dfe-4b72-84f1-3fe9f4a962e9@kernel.org>
Date: Sun, 22 Nov 2026 17:28:45 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: make folio_walk_start()'s locking asserts
 scalable
To: xu.xin@linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 borntraeger@linux.ibm.com, byungchul@sk.com, chengming.zhou@linux.dev,
 dev.jain@arm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
 gourry@gourry.net, harry@kernel.org, hca@linux.ibm.com, irogers@google.com,
 james.clark@linaro.org, jannh@google.com, jolsa@kernel.org,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, ljs@kernel.org, mark.rutland@arm.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 mingo@redhat.com, namhyung@kernel.org, nico.pache@linux.dev,
 oleg@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org,
 ryan.roberts@arm.com, surenb@google.com, svens@linux.ibm.com,
 usama.arif@linux.dev, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, xialonglong2025@163.com
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102132927.301921-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261102132927.301921-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 14:29, xu.xin@linux.dev wrote:
> From: Xu Xin <xu.xin@linux.dev>
> 
> Add an additional member 'walk_lock' to folio_walk to indicate
> locking requirements for the walk. Similar to commit 49b0638502da0
> ("mm: enable page walking API to lock vmas during the walk").
> But no change is made on any existing locking behavior,
> all existing folio_walk_start() callers are currently still
> under mmap_read_lock() protection.
> 
> This change is prepared for the later patch to enable VMA locking
> asserts. folio_walk_start now operate under write-locked mmap_lock.
> With introduction of vma locks at the next patch, the vmas have to
> be locked as well during such walks to prevent concurrent page
> faults in these areas.
> 
> No functional change intended.
> 
> Signed-off-by: Xu Xin <xu.xin@linux.dev>
> ---
>  arch/s390/mm/fault.c     |  4 +++-
>  include/linux/pagewalk.h |  1 +
>  kernel/events/uprobes.c  |  4 +++-
>  mm/huge_memory.c         |  4 +++-
>  mm/ksm.c                 |  4 +++-
>  mm/migrate.c             |  8 ++++++--
>  mm/pagewalk.c            | 10 +++++++++-
>  mm/rmap.c                |  4 +++-
>  8 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 46d828926009..968f128a5232 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -412,7 +412,9 @@ __context_unsafe(/* folio_walk_end() not instrumented */)
>  	unsigned long addr = get_fault_address(regs);
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> -	struct folio_walk fw;
> +	struct folio_walk fw = {
> +		.walk_lock  = PGWALK_RDLOCK,
> +	};
>  	struct folio *folio;
>  	int rc;
>  
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 1c397be0d092..455428eaf1fc 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -184,6 +184,7 @@ struct folio_walk {
>  	};
>  	/* private */
>  	spinlock_t *ptl;

Ah, Sashiko is right here that this belongs into the public part and should get
kerneldoc.

But, "struct folio_walk" is currently filled out exclusively by
folio_walk_start(), and I'd like to keep it like that.

Also, I don't enjoy that we are reusing PGWALK_* stuff here.

Why not add a second function variant that targets the per-vma lock and branches
internally to a common helper?

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b41d7265c01bc..13f911e1db5d2 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -191,6 +191,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
                struct vm_area_struct *vma, unsigned long addr,
                folio_walk_flags_t flags);

+struct folio *folio_walk_start_vma_rdlock(struct folio_walk *fw,
+               struct vm_area_struct *vma, unsigned long addr,
+               folio_walk_flags_t flags);
+

Or something like that.

That also means that we don't have to touch any existing helpers and we won't
even have to store that type.


But now I wonder: do we need that *at all* ? It's effectively a parameter just
to do safety checks.

I'd just document locking requirements (mmap lock or per-vma read lock must be
held) and call it a day.

-- 
Cheers,

David
