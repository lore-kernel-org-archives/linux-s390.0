Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E63090D9;
	Thu, 30 Apr 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529289; cv=none; b=ag/Zd7kAWv4vOMxdor+/l1rEerKTv34+7rZ4zdZvD78ZnMsXPEuK29FnCixZv8yviyMKAcFiB7JUrvlKaDhnNivpU+PNjsbtVRNYXbQ+f3vmuQE5IXZF3gqTemYqPwB7H/KFod7OKji92tX1E0cuARvfw0puknQ8nkMRn8uj+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529289; c=relaxed/simple;
	bh=Xh84CmaGKv1WkUK/96uT1oH8nuoakdctaMHT9kdQ7iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxdISm3LpHolwanGw6uqTMkkWXPdndpKV7x3OWTTDqDCM+UToaSjrDE7jCGsDErZZdMLy5/W9Ouueqzsdk9BUsyZCfGulERIZ7kcA3rxaZNOktM/nAl1Mst7+3rq0NgRiSmRJ30A23dDB3pHIYcXEJKAw3IxZFEAhSrq+kh7qJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWa+//UH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWa+//UH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF23C2BCB8;
	Thu, 30 Apr 2026 06:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777529288;
	bh=Xh84CmaGKv1WkUK/96uT1oH8nuoakdctaMHT9kdQ7iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWa+//UHYq+dPjSoLXAcx9cuWj7EnVpcP7O364Q1BBRGP09c3qmp8aqjy5mJ/BFqZ
	 +GdtxZ05eD6hIBr00AYSYHzvGyFwvoFrS0L1GTtxc3M2jYuOJmrWbGbVTHXC796ZRt
	 SKXIP1Nn9SZJcVN83gl7xoZ2nYWSALE9Yu68iMUjMBBEbPcCUbA7DTaasY7V09Roxq
	 aHTBnhtAN3EsXFCzKuyz2/pePi5v/BtjuxgQBpkfnQK9QzrdVfrxyJwozal/FYp3fd
	 XCa7erTquf33ozwdjMJNzqHuf4co3fH5wt0EQhQd/XlhkS2iBdSZfbuJ6YR4OxOpDo
	 iF/3P97a/s24w==
Message-ID: <b2d9fe2b-abb0-49d1-8056-ac93aa232bbb@kernel.org>
Date: Thu, 30 Apr 2026 08:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org,
 brauner@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 timmurray@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka> <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka> <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afHeXY-yeTwmURWh@tiehlicka>
 <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>
 <afIZQOtaBabeHtCc@tiehlicka>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <afIZQOtaBabeHtCc@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/26 16:44, Michal Hocko wrote:
> On Wed 29-04-26 15:07:04, David Hildenbrand wrote:
>> On 4/29/26 12:33, Michal Hocko wrote:
>>>
>>> While the oom is the only current kernel user of MMF_UNSTABLE (in a
>>> sense it sets the flag) the flag should denote that any page faults are
>>> reliable because it might fault in a fresh memory and user would lose
>>> the previous content without knowing that. Not sure MMF_OOM_REAPING
>>> would reflect that reality better.
>>
>> We use it for failed fork() as well, but that's slightly different semantics (no
>> real page faults ever made sense).

Well, there is a difference: a failed-fork process was never scheduled and will
never get scheduled.

In fact, we added the MMF_UNSTABLE to the fork path in

commit 64c37e134b120fb462fb4a80694bfb8e7be77b14
Author: Liam R. Howlett <liam@infradead.org>
Date:   Mon Jan 27 12:02:21 2025 -0500

    kernel: be more careful about dup_mmap() failures and uprobe registering

    If a memory allocation fails during dup_mmap(), the maple tree can be left
    in an unsafe state for other iterators besides the exit path.  All the
    locks are dropped before the exit_mmap() call (in mm/mmap.c), but the
    incomplete mm_struct can be reached through (at least) the rmap finding
    the vmas which have a pointer back to the mm_struct.

    Up to this point, there have been no issues with being able to find an
    mm_struct that was only partially initialised.  Syzbot was able to make
    the incomplete mm_struct fail with recent forking changes, so it has been
    proven unsafe to use the mm_struct that hasn't been initialised, as
    referenced in the link below.

    Although 8ac662f5da19f ("fork: avoid inappropriate uprobe access to
    invalid mm") fixed the uprobe access, it does not completely remove the
    race.

    This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on the
    oom side (even though this is extremely unlikely to be selected as an oom
    victim in the race window), and sets MMF_UNSTABLE to avoid other potential
    users from using a partially initialised mm_struct.

Which was later changed in

commit 43873af772f8138c5cb4b76dde9c26339e89be3b
Author: Liam R. Howlett <liam@infradead.org>
Date:   Wed Jan 21 11:49:42 2026 -0500

    mm: change dup_mmap() recovery

    When the dup_mmap() fails during the vma duplication or setup, don't write
    the XA_ZERO entry in the vma tree.  Instead, destroy the tree and free the
    new resources, leaving an empty vma tree.

    Using XA_ZERO introduced races where the vma could be found between
    dup_mmap() dropping all locks and exit_mmap() taking the locks.  The race
    can occur because the mm can be reached through the other trees via
    successfully copied vmas and other methods such as the swapoff code.
...

and I am not sure if MMF_UNSTABLE is still required, as we don't leave these
stale VMA copies in the maple tree.

The process might just look like just another process that is getting torn down now.

But we'd have to learn from Liam :)


> 
> The bottom line is the same. Make sure PF fails rather than silently
> provide potentially corrupted data.
> 
>> Looking at the original patch here, using MMF_OOM_REAPING to modify zapping
>> behavior would be clearer than MMF_UNSTABLE, I guess.
> 
> Ohh, you mean to add a new flag, right?

We could do that as well, if it's of any help.

-- 
Cheers,

David
