Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533B1494C2;
	Sat, 25 Oct 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403138; cv=none; b=Vipwts6LQz9u2EcXq5vlvV5coqHszIXU7Mi27BarCByY3+VVtSjJikURj/JgFOCgDuHb+MS/oYvK8F75055BIElLSajaDyocT4oWj7AnYjRt8yLwXITdjabo3DrgOHDWVIBvSyR8Rxpyu+D99bGgVKQXQDJxpj01vLNfnaNIicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403138; c=relaxed/simple;
	bh=mj+wkbzRaNR5zIsspgGVOVDYt3h7i3Jb0OCs1Iwf+Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2gSQ1ilyfZqZV/LHTuUH0SIW6EbJsJuU40A1sDGEAAI7SKiZP4SZxs5eQneYvOuNRAfEDjNKsbZ5XwzuJIXqJeSCS186/Kcdez0cWujGnsK2mQ+DJqW40+peHm4OFSs0jLP+vQqUllLcVW4iNA2ZtjO2fsOTJ+LgDomS2GY224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 59PEaKMv770534;
	Sat, 25 Oct 2025 09:36:20 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 59PEaC71770523;
	Sat, 25 Oct 2025 09:36:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sat, 25 Oct 2025 09:36:12 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rik van Riel <riel@surriel.com>
Cc: Xie Yuanbin <qq570070308@gmail.com>, linux@armlinux.org.uk,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
        andreas@gaisler.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, anna-maria@linutronix.de,
        frederic@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, thuth@redhat.com,
        akpm@linux-foundation.org, david@redhat.com,
        lorenzo.stoakes@oracle.com, ryan.roberts@arm.com,
        max.kellermann@ionos.com, urezki@gmail.com, nysal@linux.ibm.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH 2/3] Provide and use an always inline version of
 finish_task_switch
Message-ID: <aPzgXBd34r2wVy8I@gate>
References: <20251024182628.68921-1-qq570070308@gmail.com>
 <20251024183541.68955-1-qq570070308@gmail.com>
 <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>

On Fri, Oct 24, 2025 at 05:36:06PM -0400, Rik van Riel wrote:
> On Sat, 2025-10-25 at 02:35 +0800, Xie Yuanbin wrote:
> > finish_task_switch is called during context switching,
> > inlining it can bring some performance benefits.
> > 
> > Add an always inline version `finish_task_switch_ainline` to be
> > called
> > during context switching, and keep the original version for being
> > called
> > elsewhere, so as to take into account the size impact.
> 
> Does that actually work, or does the compiler
> still inline some of those "non-inlined" versions,
> anyway?

Of course the compiler does!  That is part of the compiler's job after
all, to generate fast, efficient code!

The compiler will inline stuff when a) it *can*, mostly it has to have
the function body available; and b) it estimates it to be a win to
inline it.  There is a whole bunch of heuristics for this.  One of those
is that the always_inline attribute will do the utmost to get inlining
to happen.

(All that is assuming you have -finline-functions turned on, like you do
have at -O2).


Segher
