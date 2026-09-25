Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252B39DBCF
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317971; cv=none; b=EjvK49yIvJ+ncZTGuZe/pNYzXy715pLMmUPxORbd8Shng6sx7Swk2tg+xtEIaTdofAOe1ceIelsJmjP48gcEevJQw6FEh28A8DC/EDuesSMiKKPeeKi9UfSHgVLRrwN8fkecv0z1mymXvJzZFZTgAHTIBqQOkxQaYkjHL2PoGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317971; c=relaxed/simple;
	bh=xOahPn69qqJwSaHXWqegaZpvObEwTRDPSZd6wMIDrN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApuQGE6zjalkFHZLtLWj6jPjjYAX4KtsdeRXoRF2ZSlUG51jz/S3o+lmu33a+OmTaYeFjhucEHSifZxGgj/L36/0evp8ptDPLBKvrXGDjnbBPXEDzmuVHFnnsloJjiN5JWrCG+vDiZZ6i2m5g4ofJ52eHAorbByB+VF6TWOb3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6gss9QJ; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6gss9QJ"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34213ed0b18so27075eec.1
        for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790317966; x=1790922766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ff013h9UPO5JfvQ6KOoQNBZOiCtGEKIOGbWYKhP5c+0=;
        b=p6gss9QJ+FW+VqAr7m46o4hoTZiZYuyY8RKXwAGRLxDZINW5gd+qEJJzF6sU41W8yD
         T4DSkpk6ZdDjVC7LO99SIF6Fi7t/RA3vdn18aLS3ggHadEQqesAsh/GLxa0MEV0x1Gov
         rvKpWhDNg48d38ISxcTIn3FWNZBqmCzPrme0KYTVv6jFWTgAT8/onT0alZ52qe8NtvUp
         IU7JgbjsilcZ4WGWBcimrv7IUfrsVISSnE/R0c65/5fBiIfu74c66vL9KaXQlEIe5l2T
         2RWtoIBHQZ1f/2PdD3zzFyQ0uK/hSCQUM1c9/WkUp1bMZ5ZrTKD13x3DeDH19HltRit5
         BFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790317966; x=1790922766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ff013h9UPO5JfvQ6KOoQNBZOiCtGEKIOGbWYKhP5c+0=;
        b=06OUm5zNfCV5it7CIDpluPe2wLmK7JCeE7UA17IUZirFX/k+E49hzwQucAcHyVH2z3
         4wL1CJFIoTskn2ae70yGiNwR0MnF5Ns99axNwU3ajB8mgp/tbIGpc8RY2NTuek1oHnxi
         PwySQUxKXsDJz8GNOPbby4SXSMi3fngBVFM1sEbnyI5Tfi2MYOrnjaTASgSUh2nuLAjW
         Q5UsCWnCvcvgG7UPh3jRTSQ7rzAnMJDnfSQOfiiLQZRI+L4hkFl7kJRnASTf/D1UgA1l
         cdZBOQVfkyDCN39qRgyoNUDTPFa3JwV3dS6HZn2YMTRRMGUIXtVc+ksDcIWd6JMHVSQQ
         vaOA==
X-Forwarded-Encrypted: i=1; AKwUvBwAbccdna4NTaN4oBZcYK7OtEs43mhZnc912tpeuzEYL0g6UmLANIxA2zPltWxa5sEQN+9ldfWFTU8A@vger.kernel.org
X-Gm-Message-State: AFuF++nHfkJm+0TkMQO3vpp/QSrm+2Z4W2YNBO7IwrfjdTjuNCyY/RBi
	GAMQ8CREQwuZDlqGpNdvrpq4lVRgAT4OJhS7SHSNPnu9eiQcdqk5i3Ga
X-Gm-Gg: AYBFou2Ae1Zd6XMd7ob7Jj0vRboEXQ7eFd6SElRC0zff6WMAH0a3nVTE1fnJLKERZnA
	k1bYHhx6us9DKsg9shnLjZ1c4hT/iXDcWp0HvEHK9E0s1AzWDTR4Jip7fpEq2CFPa2Oi43gc3eI
	kKPk1jbv384/UBF99HKyZvUsxKMxJY1LY2bN7zPM+E8OTNtJLTQxbKD6DQ2XYRcia5UdE1Knzqm
	qvgovxdzMmTNJrM+uRPnEm2JxTdVrg0I1apkiZ4DmZ2iym+XLJ+tRHdpPA/VkrNpnq4582ftaMF
	iLI2sMd3hOYlkmBbN6QoSZtnQKKhlWC8o/t17wytXJQ7hOUWcOS8JD3I1hcsxu61295xmRKWQnJ
	/4aiCHWLInV+pzBgKZHHQc9MTeuyhyen/EaII8+5khxZxC1BzD6WHHcsuAfXYUfD3Cz9LxLkTmi
	iGTI1Zn20YtkC/ORFNIEQY+Lh2vlKSqD1Pi2j3KpCQODASqFbk7i9COWEEn1tyPVKn22UfKZ6lW
	p4rgX1OK0NYWnVUIbEXoXIpHZnaiEL94RXO4QdHPVWg
X-Received: by 2002:a05:693c:87c3:10b0:33b:c478:a545 with SMTP id 5a478bee46e88-34002be4604mr3482720eec.8.1790317965974;
        Thu, 24 Sep 2026 23:32:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm5786357eec.9.2026.09.24.23.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:32:45 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:02:24 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com, 
	will@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, jpoimboe@kernel.org, 
	seanjc@google.com, pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com, 
	joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYUiddxIDeLYj8v@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
 <arUbw_TIA0Uj7oXT@J2N7QTR9R3>
 <20260924125253.GY776954@noisy.programming.kicks-ass.net>
 <arUgNdqpA5U8EjjP@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arUgNdqpA5U8EjjP@J2N7QTR9R3>

On Thu, Sep 24, 2026 at 02:05:57PM +0100, Mark Rutland wrote:
> On Thu, Sep 24, 2026 at 02:52:53PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2026 at 01:46:59PM +0100, Mark Rutland wrote:
> > > What problem is this trying to solve?
> > > 
> > > Mukesh's original patch seems to be trying to check whether we compiled
> > > things correctly (such that the bug_table entry points at the expected
> > > insturction), and I don't think that warrants a runtime check, but (as
> > > per my reply to him) I don't understand why that's a thing to check in
> > > the first place.
> > > 
> > > On arm64 we only call is_valid_bugaddr() under do_el1_brk64() ->
> > > call_el1_break_hook() -> bug_brk_handler(). We only call
> > > bug_brk_handler() when HW has taken a BRK exception with the BUG_BRK_IMM
> > > immediate, and that can only be triggered by executing the right
> > > instruction (BRK #BUG_BRK_IMM), which we ONLY use for BUG(). and WARN().
> > > 
> > > So I don't see why any change is necessary here.
> > > 
> > > If the HW has somehow taken a BRK exception from any other instruction
> > > (which would presumably be a HW bug), there won't be a bug_table entry,
> > > and so __report_bug() will fail to find an entry, and will return
> > > BUG_TRAP_TYPE_NONE, same as for the !is_valid_bugaddr() case.
> > 
> > Right, so I wasn't at all sure what he was doing, Rust is still mostly
> > unreadable garbage to me.
> > 
> > But I figured I'd much rather see him use is_valid_bugaddr() to do
> > runtime checks than whatever dodgy games he was playing with that label.
> > 
> > So *if* doing runtime checks is what is wanted, then is_valid_bugaddr()
> > needs to actually work, because then it grows a user outside of the BRK
> > handler.
> 
> Thanks; I think we're aligned. :)
> 
> Before we delve into implementation details, I'd like to understand the
> problem Mukesh is trying to solve.
> 
> Mark.

Hey Peter and Mark,

It's not as a problem, it's something i faced while implementing the
ARCH_WARN_ASM, the generated assembly was not correct so i wrote a test
for it, I sent it out along with the same patch[1] but then the
discussion led to it being for all archs so I sent it out as an RFC to
know others opinion.

After Peter's last comment i found is_valid_bugaddr can use a bit more
work(atleast on ppc) so i think i am going to drop this and go ahead
with improving is_valid_bugaddr.

Regards,
Mukesh

[1]https://lore.kernel.org/all/20260915090453.1227034-1-mkchauras@gmail.com/
