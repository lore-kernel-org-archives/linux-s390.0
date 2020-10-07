Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12977 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGUiL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:38:11 -0400
Subject: Re: [PATCH 03/13] misc/habana: Stop using frame_vector helpers
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-4-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <3ad0e02d-4ab1-6fe1-6f4d-e381e4f37afe@nvidia.com>
Date: Wed, 7 Oct 2020 13:38:06 -0700
MIME-Version: 1.0
In-Reply-To: <20201007164426.1812530-4-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Oded Gabbay <oded.gabbay@gmail.com>, Omer Shpigelman <oshpigelman@habana.ai>, Ofir Bitton <obitton@habana.ai>, Tomer Tayar <ttayar@habana.ai>, Moti Haimovski <mhaimovski@habana.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Piskorski <ppiskorski@habana.ai>

On 10/7/20 9:44 AM, Daniel Vetter wrote:
...
> @@ -1414,15 +1410,10 @@ void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
>   							userptr->sgt->nents,
>   							userptr->dir);
>   
> -	pages = frame_vector_pages(userptr->vec);
> -	if (!IS_ERR(pages)) {
> -		int i;
> -
> -		for (i = 0; i < frame_vector_count(userptr->vec); i++)
> -			set_page_dirty_lock(pages[i]);
> -	}
> -	put_vaddr_frames(userptr->vec);
> -	frame_vector_destroy(userptr->vec);
> +	for (i = 0; i < userptr->npages; i++)
> +		set_page_dirty_lock(userptr->pages[i]);
> +	unpin_user_pages(userptr->pages, userptr->npages);
> +	kvfree(userptr->pages);

Same thing here as in patch 1: you can further simplify by using
unpin_user_pages_dirty_lock().

>   
>   	list_del(&userptr->job_node);
>   
> 

thanks,
-- 
John Hubbard
NVIDIA
