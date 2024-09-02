Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836701A4E7E;
	Mon,  2 Sep 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310195; cv=none; b=IwcXf6J6bczV2ImYErcuNz5ToRlO/CkPSjZSuzE0mdKugwIDtvbC4IksM4A3o40F+ei6RxSOlfKOLnHS10aqtApWvoukyyZzucDMK7zvVTjcRqQa9IEZsPX8DgjGal/UkRYp0ADXv5sp/Ij5nU1QzmO5HhzAirHe/jXQLMXY/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310195; c=relaxed/simple;
	bh=plMpypI6Wercf2AMqEeD8hJy/zS1sMK2nF2Og4ULyOw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZDNZHFVSl7NOeT4kVIwB7G15gJQ1YBg41Y3ezLQIFKMWHS42Iabz4sDT0tsAOArmb4SWE9OzJEsllVZpgriQ5JEzg/aCniqeluLqmLFIlkn76bFSoggUg+gcHtbwhcMSVIlpAZOTHYOnGptZtAOZRUa+Fm3Fxm2ykohqJYnPSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gHiMeoWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gHiMeoWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69389C4CEC2;
	Mon,  2 Sep 2024 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725310195;
	bh=plMpypI6Wercf2AMqEeD8hJy/zS1sMK2nF2Og4ULyOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHiMeoWa0lzT85g1imdgbajsEHzGCaCYUlk/ONYUe6Zp7GrwM6LszSffkEbLgdXRr
	 dHZltfJQaFh2HH5t9EAQ3UnL3Ixs52lRSxs09kbyRMkq2VD1ynpM5lHjNHH+VRSQRI
	 VYoQuFvj+E/HihP+bWCJ+ELFTH2RSC3ESwGcFY+o=
Date: Mon, 2 Sep 2024 13:49:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 torvalds@linux-foundation.org, christophe.leroy@csgroup.eu,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Ravi Bangoria
 <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
In-Reply-To: <yt9dy149vprr.fsf@linux.ibm.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<yt9dy149vprr.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Sep 2024 21:06:48 +0200 Sven Schnelle <svens@linux.ibm.com> wrote:

> So uprobe_clear_state() in the beginning free's the memory area
> containing the vm_special_mapping data, but exit_mmap() uses this
> address later via vma->vm_private_data (which was set in _install_special_mapping().
> 
> The following change fixes this for me, but i'm not sure about any side
> effects:
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index df8e4575ff01..cfcabba36c93 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1340,11 +1340,11 @@ static inline void __mmput(struct mm_struct *mm)
>  {
>         VM_BUG_ON(atomic_read(&mm->mm_users));
>  
> -       uprobe_clear_state(mm);
>         exit_aio(mm);
>         ksm_exit(mm);
>         khugepaged_exit(mm); /* must run before exit_mmap */
>         exit_mmap(mm);
> +       uprobe_clear_state(mm);
>         mm_put_huge_zero_folio(mm);
>         set_mm_exe_file(mm, NULL);
>         if (!list_empty(&mm->mmlist)) {

uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
seem unlikely?  
