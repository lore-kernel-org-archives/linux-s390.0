Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 5 Feb 2013 11:28:21 -0800
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] software dirty bits for s390
Message-ID: <20130205112821.0e35b241@mschwide>
In-Reply-To: <1360087925-8456-2-git-send-email-schwidefsky@de.ibm.com>
References: <1360087925-8456-1-git-send-email-schwidefsky@de.ibm.com>
	<1360087925-8456-2-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  5 Feb 2013 10:12:04 -0800
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Greetings,
> 
> good news, I got performance results for a selected set of workloads
> with my software dirty bit patch (thanks Christian!). We found no
> downsides to the software dirty bits, and a substantial improvement
> in CPU utilization for the FIO test with mostly read mappings.
> 
> The patch can now go upstream.

Grumpf, 0000-cover-letter.patch~ in the outgoing directory.
Please ignore.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
