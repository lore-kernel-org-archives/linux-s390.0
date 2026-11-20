Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189139;
	b=dU7lVTh7S0Yol2dazpzcE8+8+riVEiSLpuqnDF1DQ8Tev75QTLK14I38dgy6RjHcqtjV
	 hU5ISnPNu3wCR+7zvUXQCxJTrGtPnVK4JIZGFcyjTGQxXTVKtv3k+GsCGkDSxdIhq3EPV
	 H7FJmOuEkeQXgXNp5G2/XCmjmGgiSUN0At8iwwnLHlY84xv7Rynvk1euh7EdvwqR1q4iM
	 S6YAhCGdK/D8FH+L3VOsmrwYWFGx3MrBqC8wsrNsicOOvx+jTeLBLR8k2rhlhOP8YvWYc
	 TJwP0mwLq79RAnyCUuQWvBCL0VepV8RDEoFxR+P3GaG/tDqH6897owT4p7Sh9+NhHSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189139;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ppma177xKCtM0AAFLCO+Tq23UhbXnES0BuYn6WWoAG8=;
	b=XdoDvAtZscMs7tDI/VUu6fNxlRa9yyz+5EobKA8vRRomn7/TDIKibo/fyckKEcWDrYEA
	 ordl76T3G8wQTRUV70eg9FZvOKjOwDXXDeAuazedpImugCLJ5sbtFfcwzW+W6baXfuzWf
	 JLF4sZreCv/AqWdiNKDiKrszkgGDxmKn3cB80lXVbnLcL/sDEfjaGjmuqJuBd8voLcL9u
	 30ZtjAJdClhkw1U2T4wlVvpl168EY8wqgXAWjQcEzwKVE6yEND71kL/waZUZMrP2qwT+y
	 ukQAAHCvpuR8OQZAw5kOx62EsmRcxSzphjc54mDY81en5m3KGGawamcgn+5dMBNvAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=raLOMns4;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A4606A32A;
	Fri, 20 Nov 2026 15:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE3A4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=raLOMns4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ppma177xKCtM0AAFLCO+Tq23UhbXnES0BuYn6WWoAG8=; b=raLOMns4K9SwOuSK34ikQgnTHO
	aiOzsmjqH2fXT0KM/o7u+2eSGyZT9WP61WYGsHczn3gUw0Tf57qNJRYEOapN0/sfO/yEKk/h8leoQ
	oM8OLYE+Fv6JuKgI/pYvwIOa35YixOD8jKJagWrxxsMgpeCXBJ6AXemT8sNflvTxNke1vknzDGbLw
	VN/XAGw1w1/CEHl6kOu4yRVH9wxCRvUli+ZYFlHcdxn/rfjWEF0IMgK6PJgOiEtxJ7XCa0DSNfaUP
	GKtILZ/TQw5MLB0sE/jA5FmbwwRC+JWxjlnfVBAyvuVmPvBMLjPSrVl7dj1zlVl1pFhZOo10dAt5k
	YgzlbzJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQhR-00000000ug4-2AfN;
	Fri, 20 Nov 2026 15:38:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D63B302431; Fri, 20 Nov 2026 16:38:51 +0100 (CET)
Date: Fri, 20 Nov 2026 16:38:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
Message-ID: <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113184257.621707-8-ynorov@nvidia.com>

On Fri, Nov 13, 2026 at 01:42:56PM -0500, Yury Norov wrote:
> Serializing preferred mask updates still lets competing policy drivers
> repeatedly override each other's selections.

Competing controllers is not going to happen.
