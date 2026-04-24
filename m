Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68721369204;
	Fri, 24 Apr 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058121; cv=none; b=iSENtm444a7JdmCh0BdtAXSpGNC+4E5ZB3kyxfcYZume7Qdmc6OjDyIeo3yFz3/zu3G/HJUluiK130V/V80EVFGgvjhs+fl11gRQxZeXUDkM2sJOLZVoyU2zBFehCzwJ83+WRfGZPAVnCpf33NxN0TyCJOpmHNY0yTzRVUtUWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058121; c=relaxed/simple;
	bh=elAiMYYB8thnLDPWGWuzFWDG9U2HmB7k3ICkW3UnRss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qArS3lAs0qYv4UcYEFPzmTAW1ZwYuOs5YNAfP/vB8KcWTonP/jVpvTPX9Kqoir6Z4QvO/VJSlhuiV57To1sTB2RpM7td1r4Pa7Bd/ClyzazDCNVDizjcx4ajbTkZWieum8mvAgUO/ytWmrLndN7cU6zmYS+PtqN4wJQ7Abl0fW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqMFc8Um; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqMFc8Um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC6DC19425;
	Fri, 24 Apr 2026 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058120;
	bh=elAiMYYB8thnLDPWGWuzFWDG9U2HmB7k3ICkW3UnRss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqMFc8Ummu0HNQYO0qnqYhFMafW5AXr1X1GDRJ7ovxKkZyWFWtJKmS2mWc4jHDW1D
	 YLptaVzHms+E8S11zRFdecHEn7H4PsyF+GZxHXAuTuBCxSL8ALxMUlrQUu0QUPLFIJ
	 jF3AQsgzAKV9C6siKoTwRRxC0xQKhVVbkyYvp61FIZ5L2sOLM9vXGxvV8i0M9jLU+H
	 G6T1uQjLRLF8ciQ+VDJgJtttVdDtWSV2OmIo0IAtFVvBu3WxAh5Sc0w60jiqnE8OGb
	 sYgZ1Aca5NVmjdLZGq2HdClqASNSDiJM40TcOLWWW/594ed2rJ54G70Ga59yuNZvlw
	 Pkhr4HzGB/jnA==
Date: Fri, 24 Apr 2026 12:15:18 -0700
From: Minchan Kim <minchan@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <aevBRh08X4UTMUj9@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>

On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote:
> On 4/24/26 09:51, Michal Hocko wrote:
> > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> >> For the process_mrelease reclaim, skip LRU handling for exclusive
> >> file-backed folios since they will be freed soon so pointless
> >> to move around in the LRU.
> >>
> >> This avoids costly LRU movement which accounts for a significant portion
> >> of the time during unmap_page_range.
> >>
> >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> >>      exit_mm
> >>      __mmput
> >>      exit_mmap
> >>      unmap_vmas
> >>    - unmap_page_range
> >>       - 55.75% folio_mark_accessed
> >>          + 48.79% __folio_batch_add_and_move
> >>            4.23% workingset_activation
> >>       + 12.94% folio_remove_rmap_ptes
> >>       + 9.86% page_table_check_clear
> >>       + 3.34% tlb_flush_mmu
> >>         1.06% __page_table_check_pte_clear
> >>
> >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > As pointed out in the previous version of the patch. I really dislike
> > this to be mrelease or OOM specific. Behavior. You do not explain why
> > this needs to be this way, except for the performance reasons. My main
> > question is still unanswered (and NAK before this is sorted out). Why
> > this cannot be applied in general for _any_ exiting task. As you argue
> > the memory will just likely go away so why to bother?
> 
> I think there was a lengthy discussion involving Johannes from a previous series.
> 
> That should be linked here indeed.

How about this?

    mm: process_mrelease: skip LRU movement for exclusive file folios

    During process_mrelease() or OOM reaping, unmapping file-backed folios
    spends a significant portion of CPU time in folio_mark_accessed() to
    maintain accurate LRU state (~55% of unmap time as shown in the profile
    below).

    This patch skips LRU handling for exclusive file-backed folios during
    such emergency memory reclaim.

    One might ask why this optimization shouldn't be applied to any exiting
    task in general. The reason is that for a normal, orderly exit or just
    pure kill, it is worth paying the CPU cost to preserve the active state
    of clean file folios in case they are reused soon. Preserving cache hits
    is beneficial for overall system performance.

    However, process_mrelease() and OOM reaping are emergency operations
    triggered under extreme memory pressure. In these scenarios, the highest
    priority is to recover memory as quickly as possible to avoid further
    kills or system jank. Spending half of the unmap time on LRU maintenance
    for pages belonging to a victim process is a bad trade-off. If speeding up
    the victim's reclaim by avoiding LRU movement and evicting cache negatively
    affects the workflow (due to immediate restart), it implies a sub-optimal
    kill target selection by the userspace policy (e.g., LMKD), rather than
    a problem in this expedited APIs.

    Therefore, we choose to prioritize immediate CPU savings and faster
    memory recovery over potential future cache hits for the specific victim's
    files.

    Profile showing the overhead of folio_mark_accessed during unmap:

    -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
         exit_mm
         __mmput
         exit_mmap
         unmap_vmas
       - unmap_page_range
          - 55.75% folio_mark_accessed
             + 48.79% __folio_batch_add_and_move
               4.23% workingset_activation
          + 12.94% folio_remove_rmap_ptes
          + 9.86% page_table_check_clear
          + 3.34% tlb_flush_mmu
            1.06% __page_table_check_pte_clear

    Signed-off-by: Minchan Kim <minchan@kernel.org>
