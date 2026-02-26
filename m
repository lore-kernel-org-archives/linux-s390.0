Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085653624D3;
	Thu, 26 Feb 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124714; cv=none; b=eOULYYjQD6aEkF/JbUeoZP35JzoQ/jkqu0HEsO5sEk+BopVK0o7UcXaH++le17FI3whKTknpcCEzQckQF2ZShL+uOUgcC2YnZIZWE5Fi8sOjfqUr98fs2YRiBEJH5WblLzFxUXo7WxlCYCI78VgZ+IcUW0+qGwChQi+bepkgyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124714; c=relaxed/simple;
	bh=IPewdWEuDJPN1wrrJn7zkJ6m649oxY82U1YH4vSWFDY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FV2GFaLxmnaJ8aXTg3ZzezmFzzW4RMQ5JnlO/z+5SWNYYQ43qJQH07exThyUn1fW8L8H6mVU25+6qA3d12ctzadGe5sEdB6ditfVyC7DrlQxkMb9urLU2d2KQbaULqWK2Paa+ryLcGUzv01VeFNKcZpoeTjTgSGoSqHOYi9SwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CLOrJ99V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CLOrJ99V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B6CC19423;
	Thu, 26 Feb 2026 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772124713;
	bh=IPewdWEuDJPN1wrrJn7zkJ6m649oxY82U1YH4vSWFDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLOrJ99VdWcDT0IbDuGEAeDxxsMm4VIEQzVddev32PfavjRnLGG21VaqAg7wNDcfh
	 C4KA+DPKtjPjxYTVPZS/jGHoI4PT5N8sClpu7c0rKw1pLceTzXePotMi+uedf/wNKS
	 cOAmyKQn/HKWcBJZNNIpqHwqTXGu6+wj9UQlGvgo=
Date: Thu, 26 Feb 2026 08:51:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Martin Liu
 <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>, SeongJae
 Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <liam.howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, Miaohe
 Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, Yu Zhao
 <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Mateusz
 Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Aboorva Devarajan
 <aboorvad@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
Message-Id: <20260226085151.d1a7e7048d8f60a173d613ae@linux-foundation.org>
In-Reply-To: <20260226120422.8101Cc2-hca@linux.ibm.com>
References: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
	<20260226120422.8101Cc2-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 13:04:22 +0100 Heiko Carstens <hca@linux.ibm.com> wrote:

> This seems to cause crashes with linux-next on s390, at least I could bisect
> it to the last patch of this series. Reverting the last one, makes the crashes
> go away:
> 
> 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 is the first bad commit
> commit 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 (HEAD)
> Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate: Tue Feb 17 11:10:06 2026 -0500
> Commit:     Andrew Morton <akpm@linux-foundation.org>
> CommitDate: Tue Feb 24 11:15:15 2026 -0800
> 
>     mm: improve RSS counter approximation accuracy for proc interfaces

Thanks, I'll remove this series from linux-next for now.
