Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704165;
	b=zqHgS1AWeB0LX1Xun7kB/C2PV/gexrzJIYvnV12QNqluedLcxaEfN4h/ISJSjc9qd0TH
	 RBtwkrgNg4kvPs/6Kk+bvDMpUTdpMbMNXJ7KdQGXHTf+YLuYRi7m+Woi7iDPVJSqU9g6u
	 Vfb6jE8xjtRp2fM2916iXF5MB+1x2qSYOsb7T5xf17aT5C/t2YWRGWzcDlbrzH7Jsjh8F
	 XxWFuSDk/EeNjunWEzLmXF3VYkCZDpwgkznpJRDr6W8UhJ6/E37qR5LRIsINE+0yRX5Ms
	 OwxmFDklrM6A/BzWNn7H0j9yMiXqSogeLJrC93GMBFgyK35PBkMWDtDOxSAne3PjA4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704165;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=qarcZZQ4Pvpd+Eskx/ZkJsQlIkAUMYn0G23lRSUKBm0=;
	b=zXueHGTl4Vxd6vq5Ctxtsi1X88qFJOJcSVLAWKInFgbpXOW1z757JGI3srvLaKX24wwJ
	 4pgsMeGcuWlCQ2x13PsZNunMaXsouBwhQ4Re/S6zUE14Rs5ye23B+VqYagDhI4/NOm2YG
	 B6rV+wszZ4WSFnasE/yfbGxyVGSW+r7biYqvuGPp61DKrxd6oWT90ODer3dBcvOw41ozH
	 H96JxeBC727zTFI04P+nk89q4Np39AMJGcNgajib5ZnIRzKHfstoHsW5XUUyoabthT+5l
	 qdmUdW5bQOGPHLapI9qUCnclaen44SEtvmqARYybtTWJVliJyAA4MQOp6mUX2p30+WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ln7e1AWP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rhPGPUCZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wTzFlnuf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zfj8vy6k;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F6606B11D;
	Tue,  3 Nov 2026 11:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E89F6606B11D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ln7e1AWP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rhPGPUCZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wTzFlnuf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zfj8vy6k
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7D801F851;
	Tue,  3 Nov 2026 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793704163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qarcZZQ4Pvpd+Eskx/ZkJsQlIkAUMYn0G23lRSUKBm0=;
	b=Ln7e1AWPqeO8tey/St9gMxw10zhgzRhc1E0p2nvZhQtEV14ZmWpJVgF+m29cCeKL+vMeWh
	AwxNYUaIHh8FuS4VEVaDKyYdAJIarC9nSWLtPrfutX1ksDb927/ks7ay3EOxy9Qq02+LJh
	1er4GydxR8h3wKecEqyfOQ/nozZFjvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793704163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qarcZZQ4Pvpd+Eskx/ZkJsQlIkAUMYn0G23lRSUKBm0=;
	b=rhPGPUCZar1qg51irSrmQHzi+MOh+2VhGXgHXgsGqvA7LbbTMBC/EfNjrbW398wrMLlMC2
	jxxEwL2u6nJXhDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793704162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qarcZZQ4Pvpd+Eskx/ZkJsQlIkAUMYn0G23lRSUKBm0=;
	b=wTzFlnufB/O28OfM/In9u0tun+XTcYCPxKNYphDoQxX/q1Wn0QyGWGwN5TH10K+vvmZLRQ
	9UZZrAEtROwLE/zMUGXnBzPvqru88IfWaDbjzjYe1FsRoKeFMifbNZ3XKx8oShGxAhJWKp
	zUPqtsbpDv+D0knpvzWDGE+7xh/os5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793704162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qarcZZQ4Pvpd+Eskx/ZkJsQlIkAUMYn0G23lRSUKBm0=;
	b=zfj8vy6kaGRbelluWH4W02FeRwUOKocR4zt+QWcBMhrTWP/MobG6BkLFjqU1YdkyottYX1
	oquHdH72L94+peCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF861350A;
	Tue,  3 Nov 2026 11:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jOBJAOLA6WrZLgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 03 Nov 2026 11:09:22 +0000
Message-ID: <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de>
Date: Tue, 3 Nov 2026 12:09:17 +0100
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
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
To: Sean Christopherson <seanjc@google.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com,
 linux-s390@vger.kernel.org
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de>
 <20261030133939.630e29af@p-imbrenda> <auis0SaMkRB6odsK@google.com>
Content-Language: en-US
In-Reply-To: <auis0SaMkRB6odsK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

On 11/2/26 4:31 PM, Sean Christopherson wrote:
> On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
>> On Fri, 30 Oct 2026 12:11:07 +0100
>> Carlos López <clopez@suse.de> wrote:
>>
>> [...]
>>
>>>> regarding this series:
>>>>
>>>> on x86 you don't care what the new permissions are, because you're
>>>> updating when re-faulting (if I understood correctly).  
>>>
>>> Correct.
>>>
>>>> for s390 it might be beneficial to know what the new permissions are;
>>>> of course we could look up the vma and find out, but since you are
>>>> already checking the permissions, maybe you can find a way to also
>>>> convey the new permission bits?
>>>>
>>>> that would make our life on s390 easier :)  
>>>
>>> Right, getting the new bits from vma->flags should be trivially done
>>> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
>>> this series though.  The rest of architectures still need the notifier to
>>> tell them if the change is an upgrade, since they don't have an easy way
>>> to grab the old RWX bits. Passing the old RWX bits from the MMU notifier
>>> does not seem trivial to me either.
> 
> But why is core MM even doing mmu_notifier_invalidate_range_{start,end}() in the
> first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip the
> "invalidation".

I briefly mention this in the cover letter, but in short, denying other
users the notification seems like an overly intrusive change for KVM's
benefit. A flag allows users to opt in instead.

It is also not clear to me that secondary MMUs are not relying on the
notification in some subtle way. In fact, Sashiko points out in reply to
patch 4 that the notification lets KVM retry the APIC access page reload
in case userspace shoots itself in the foot by calling
mprotect(PROT_READ) on it. This would require a really weird VMM, as it
would need to go looking for the page's address, but breaking this would
be a "regression" nonetheless. I will address this in v2.
