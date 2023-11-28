Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE146481C4
	for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jrz8eaHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D11DC433C7;
	Tue, 28 Nov 2023 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701215795;
	bh=nvsvvynpek/zOvf0pUPcypWcMGJ2PtkOtXpvUsfR7I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrz8eaHzA/MashuzJGaOE+p4xwEr91K2ATTCNE0r3vnKRlVVBbxVznDltfPazcRJS
	 xeDyx7roDh6QPiu9/3l8x+0m4WF39kLpHZ9Hf3vO5ihFPwyJmn/wqvkjztaSnKkkLc
	 7XV607/1kxyW9pJvmVyRRqEegxMLIuT6naqt7JL4=
Date: Tue, 28 Nov 2023 15:56:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] implement "memmap on memory" feature on s390
Message-Id: <20231128155634.9c325682d2cf87d0a6d48728@linux-foundation.org>
In-Reply-To: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
References: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:52:22 +0100 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:

> The patch series implements "memmap on memory" feature on s390.

The cover letter doesn't acutally have a description of what "memmap on
memory" *is*.  A nice overview to help readers understand what they're
about to look at.  A description of what value this feature brings to
our users.  Use-cases.  That sort of thing.

I guess the [1/N] changelog covers it, but it's hard to tell.  It isn't
exactly broad-sweep overview.

Probably something short would suffice.  There are plenty of examples
on the mailing list, please take a look and send us something?
