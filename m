Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 27 Nov 2018 11:46:26 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
Message-ID: <20181127084626.a4l65sqqipqukrx7@kshutemo-mobl1>
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 27, 2018 at 09:36:03AM +0100, Heiko Carstens wrote:
> Use pr_alert_once() instead of pr_alert() if page table misaccounting
> has been detected.
> 
> If this happens once it is very likely that there will be numerous
> other occurrence as well, which would flood dmesg and the console with
> hardly any added information. Therefore print the warning only once.
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Fair enough.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
