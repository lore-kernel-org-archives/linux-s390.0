Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 31 May 2017 12:51:18 -0400 (EDT)
Message-Id: <20170531.125118.94140984076231176.davem@davemloft.net>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170531163131.GY27783@dhcp22.suse.cz>
References: <20170529115358.GJ19725@dhcp22.suse.cz>
	<ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
	<20170531163131.GY27783@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: mhocko@kernel.org
Cc: pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 31 May 2017 18:31:31 +0200

> On Tue 30-05-17 13:16:50, Pasha Tatashin wrote:
>> >Could you be more specific? E.g. how are other stores done in
>> >__init_single_page safe then? I am sorry to be dense here but how does
>> >the full 64B store differ from other stores done in the same function.
>> 
>> Hi Michal,
>> 
>> It is safe to do regular 8-byte and smaller stores (stx, st, sth, stb)
>> without membar, but they are slower compared to STBI which require a membar
>> before memory can be accessed.
> 
> OK, so why cannot we make zero_struct_page 8x 8B stores, other arches
> would do memset. You said it would be slower but would that be
> measurable? I am sorry to be so persistent here but I would be really
> happier if this didn't depend on the deferred initialization. If this is
> absolutely a no-go then I can live with that of course.

It is measurable.  That's the impetus for this work in the first place.

When the do the memory barrier, the whole store buffer flushes because
the memory barrier is done with a dependency on the next load or store
operation, one of which the caller is going to do immediately.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
