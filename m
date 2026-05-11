Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80673BAD90;
	Mon, 11 May 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504748; cv=none; b=GOdaSCBcGHNXOw+LtTi1WDk7wngJ0iZPW8wR7F0lxcysqueJRRXUwpzEnkq9HE9SdKnDT7EXr/Pghsdd9awP17te8Rp3yXT4pu6p8fzGZ5dNzK6oRpNDgZmK2AD5Fg3UTQPFt6VRG+dbRC6vWwPdixnTsk1aP8GmfAvaQz28UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504748; c=relaxed/simple;
	bh=D4TZ2PDbQ1D4kjvzq/nrJ+Uq6CeX3FneZzCQz8PjBeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBCfyR0yEDx4Hew35RAVVb8msv4ZWSq/aac/CgT7B2FbZlo3fEZS09Cd2bTRMNIQ2T1HHpwT5x0CyDMACKdSOmk/FlzUsKmbc1OoJWCTOX0nvP3hIzXbyIYGU+cYJZYJhNDe2gD5ZVk2AzZ3wLcaSEIBmAPIqndANxb3i8JfCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDDYWlLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDDYWlLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B48C2BCB0;
	Mon, 11 May 2026 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778504748;
	bh=D4TZ2PDbQ1D4kjvzq/nrJ+Uq6CeX3FneZzCQz8PjBeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tDDYWlLU6lMBmIRR99eo79X8GJzcf/TVADyvfp3K4/zs7YokACeF1tOsC947D162J
	 JNxZC0BnVx4IZGnIM6dL4UXmE7Tz5c36rdrkb/pNiRKxHojvEMS1JGVEaOI95wPXJq
	 Wro67TeQLzRvccM4SvXngRjGeZBKPxYJo2Xj7Q2BUYV0pn3korL6Kt3FVaei9ghdyL
	 +HHzQhYKaltX2xrJVj4JO3KPWQOgYdInXEw5NFY0kdbel72ut0cPRW4/8iTaBuHVPs
	 +Q0dH/8Bou1kJbS2k4a/5b7K2yaPpCmv56aTRPnYuOAduo5DX4oxCOPyhH4RvV5Qpp
	 uxo6JudqRrdHA==
Message-ID: <4df23f32-c538-4755-a1c9-be8559a103a3@kernel.org>
Date: Mon, 11 May 2026 15:05:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, timmurray@google.com,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <ae-Zu-VAzAA7SdLa@tiehlicka> <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka> <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afHeXY-yeTwmURWh@tiehlicka>
 <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>
 <afIZQOtaBabeHtCc@tiehlicka>
 <b2d9fe2b-abb0-49d1-8056-ac93aa232bbb@kernel.org>
 <7g5g57jbll5joujbwjb4osqhdwqd4yzc54wmoi7ftx4a4chuax@xtxyljtqaodp>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <7g5g57jbll5joujbwjb4osqhdwqd4yzc54wmoi7ftx4a4chuax@xtxyljtqaodp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>
>> But we'd have to learn from Liam :)
> 
> Yes, it will be a zero entry tree now.
> 
> I left the flag to indicate that it's an unstable mm, not for faulting
> in but to be skipped in OOM events and process_mrelease since neither
> should bother doing anything in the window between the dup_mm() failure
> and the exit_mmap() window where the write lock was dropped.
> 
> We can safely drop the flag now if you want to, because everything has
> to deal with an empty vma tree anyways - a race can occur between a call
> to unmap everything and the task seg faulting.

Thanks for confirming!

> 
>>
>>
>>>
>>> The bottom line is the same. Make sure PF fails rather than silently
>>> provide potentially corrupted data.
>>>
>>>
>>> Ohh, you mean to add a new flag, right?
>>
>> We could do that as well, if it's of any help.
> 
> I really think this goes back to the life cycle of the mm being somewhat
> difficult to figure out.  

Agreed.

> I'm fine with another flag.

Right, alternatively we could just turn the unstable flag into a "OOM is hiding
in the bushes to reap this MM".

-- 
Cheers,

David
