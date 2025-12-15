Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC423E342
	for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820358; cv=none; b=oJqRN1WdQYh0t4mPwZynVvn2ziV3MLr8T/4Y6v5kZjn8dae0N/vZK1MD/yjq52hVRhQ6SKgTNUjMGSkqQSvTbFyGZxNQ0G+P8WtujqyDj0kCwaHUFUkkPmfVD1x8NHtUVHHS35Uo1f7wJEPdyqp/OHtw5AMqL+GLpP/atj5YuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820358; c=relaxed/simple;
	bh=j0x2jatFz4hBIq166WLNrHpebMbejyhRMdUSlqLvFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYU/NP/nMZ+e8zCht4OMuh7vpUCNmlaIcybuXFg9P5Azg1Uqa2OKk2bIQS07n6NP0iaNsWdy32shOFwApeLLvnXnXHPYC+8yFo2KnuCJQ4zdAx9JvrMSHHxU0f8G7tf1uehroTn1itIT/KXfuy3R5pZRwMGJhWuupodzgmGbPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deIjMUaX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deIjMUaX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787da30c50fso36527247b3.3
        for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765820356; x=1766425156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwO+8R3t08cYN0VAj8/l4kKgUUQ8j2xcSUHY0WIH+XI=;
        b=deIjMUaXYlPZbN74qtUO85/PKy5LRHI6KCTGYgrt5GhLP+FQP080Z4t6mugNAy20y6
         InivyOhwZuxGTF6FXcKgsKnyGUgeUG+yq9mNra2Xq3UNHh2MkYOSVCtflAZPx/57se1A
         maVdMrs/gmGcFaguaeeO0CanWlutrUa7jttpVar0Q+fbFYKGivefB3r4BHC3EZs1PD8j
         phi2QdKb73Lfh+z1LoGJ54PWZ5mzyo086JUcdKDHs5XiB14gcwZL3n7kZnl6Nc/7q2V8
         F/MRgBpcbCHdB4caMn+nK4TAn3lPufjinu8wNagswyyAjF60FH/BJHMKxf8FYSUAY1VB
         SiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820356; x=1766425156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwO+8R3t08cYN0VAj8/l4kKgUUQ8j2xcSUHY0WIH+XI=;
        b=PDaS5alcSP5zt3TWWfmtObIR4ZXDD/DqmWTKzRgbrldpB2kN35WKe/XqImEjSDejyn
         n47V0/ylgkmu+6eQq8/fOaDAQw+47Xmk3qf8dDBtP5PCrfqvH+jSVp7n/Oe6OTU1r7nE
         /XrWpnQfJKtvfcnn/zI7O4mcq/zW3aCafQSvi7/i+F+l+NJcHnJZ+VhC5up1Vh8x4+10
         nlWnUPzc/SqPiXlFaAXEWQWjAoov5upiME/Zz6lpeQ3LSGhIERtuO3cEy33dwSCBBvR0
         cvROV1EvNwIwCsEKqF+67Kokmj0Qai3+06JEL39qpBNWtC5RejEVwMuwXfSs70ZxTEND
         Nt0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrrmIY+bz5eINwN2aeY/t136FY2AkkVRI3VQQcLCeXtBcfu03lsX0t6WWXljipSMpHhzeao9qIF1FV@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOgS2cUXza1/qvC30eXzqtEuVcfHQafLNOxhPzCAUJ4LkazGV
	xM09EIT3WgvATFekXPsATFHtL/WfyWAFbbUz92E34FoeIPQgpXreNcZ+
X-Gm-Gg: AY/fxX4RLelwIL4MzCh6ysoKhQmLxPgJnSB7vajGClE5hXg7Sm4N4Nfpm7EU5UAI3ZW
	1KENXNXxFN/Df6gOr7AsjqytiysWWiiP6+c9VAvIUhLG2Cu1CRCW9Ym+brhABeRsk4S0sgh8Pbh
	YR7jNH53PS+fZ8crBXWm1vSgBu2kve+1acZmHeTYUDkptp70nmBlNPGsA+MUvZhNs5uYaXS9p06
	+BLWcNL5qdUJEzRn6J6TMF7lUijyr5PIfcZs+sWxw1dCjls+hU1gZc9y1zOIYwyCx1t/W2+MG5e
	wwhByy71yXgfLhRjH7AOvqwS8V2BAcq8XBLLHv4V+OAWCxU6vIXqWP/fpAWKmnonZAfA1Frx3Td
	9s7kJoLtsVGh2I7y6gLvILd6S+Zy77ycHZNLY0eSfpOLRdhEMGKMLcwOo/wGOeFbDeJqGpSjpfu
	Bbl6OlKg==
X-Google-Smtp-Source: AGHT+IFw4kFr+qFTpX4ESaGTfCJoDkf+gfiQIDxCC2ZRMB7wGug95gwKVuhwJJInotzA/whJCBuumw==
X-Received: by 2002:a05:690c:4d45:b0:788:161c:7117 with SMTP id 00721157ae682-78e66caa12amr228474327b3.8.1765820355853;
        Mon, 15 Dec 2025 09:39:15 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a43c4fsm29871577b3.50.2025.12.15.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:39:15 -0800 (PST)
Date: Mon, 15 Dec 2025 12:39:15 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tglx@linutronix.de, maddy@linux.ibm.com,
	srikar@linux.ibm.com, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, kprateek.nayak@amd.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, christophe.leroy@csgroup.eu,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 00/17] Paravirt CPUs and push task for less vCPU
 preemption
Message-ID: <aUBHw7MvOQYusuuA@yury>
References: <20251119124449.1149616-1-sshegde@linux.ibm.com>
 <4ddbb5a1244cf444f330cc73b7d573f47b02f7eb.camel@linux.ibm.com>
 <8368868e-48aa-4a90-95d1-1be4de9879e8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8368868e-48aa-4a90-95d1-1be4de9879e8@linux.ibm.com>

On Fri, Dec 05, 2025 at 11:00:18AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 12/4/25 6:58 PM, Ilya Leoshkevich wrote:
> > On Wed, 2025-11-19 at 18:14 +0530, Shrikanth Hegde wrote:

...

> > Others have already commented on the naming, and I would agree that
> > "paravirt" is really misleading. I cannot say that the previous "cpu-
> > avoid" one was perfect, but it was much better.
 
It was my suggestion to switch names. cpu-avoid is definitely a
no-go. Because it doesn't explain anything and only confuses.

I suggested 'paravirt' (notice - only suggested) because the patch
series is mainly discussing paravirtualized VMs. But now I'm not even
sure that the idea of the series is:

1. Applicable only to paravirtualized VMs; and 
2. Preemption and rescheduling throttling requires another in-kernel
   concept other than nohs, isolcpus, cgroups and similar.

Shrikanth, can you please clarify the scope of the new feature? Would
it be useful for non-paravirtualized VMs, for example? Any other
task-cpu bonding problems?

On previous rounds you tried to implement the same with cgroups, as
far as I understood. Can you discuss that? What exactly can't be done
with the existing kernel APIs?

Thanks,
Yury

> > [1] https://github.com/iii-i/linux/commits/iii/poc/cpu-avoid/v3/
> 
> Will look into it. one thing to to be careful are CPU numbers.
