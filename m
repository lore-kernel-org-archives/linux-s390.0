Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 31 May 2017 18:31:31 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-ID: <20170531163131.GY27783@dhcp22.suse.cz>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
 <20170515193817.GC7551@dhcp22.suse.cz>
 <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
 <20170516083601.GB2481@dhcp22.suse.cz>
 <07a6772b-711d-4fdc-f688-db76f1ec4c45@oracle.com>
 <20170529115358.GJ19725@dhcp22.suse.cz>
 <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

On Tue 30-05-17 13:16:50, Pasha Tatashin wrote:
> >Could you be more specific? E.g. how are other stores done in
> >__init_single_page safe then? I am sorry to be dense here but how does
> >the full 64B store differ from other stores done in the same function.
> 
> Hi Michal,
> 
> It is safe to do regular 8-byte and smaller stores (stx, st, sth, stb)
> without membar, but they are slower compared to STBI which require a membar
> before memory can be accessed.

OK, so why cannot we make zero_struct_page 8x 8B stores, other arches
would do memset. You said it would be slower but would that be
measurable? I am sorry to be so persistent here but I would be really
happier if this didn't depend on the deferred initialization. If this is
absolutely a no-go then I can live with that of course.

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
