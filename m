From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [REVIEW][PATCH 15/22] signal/s390: Use force_sig_fault where
 appropriate
Date: Mon, 23 Apr 2018 07:44:37 +0200
Message-ID: <20180423074437.1203f39f@mschwideX1>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-15-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143811.9994-15-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Apr 2018 09:38:04 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
> 
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
> 
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/s390/kernel/traps.c | 32 ++++++--------------------------
>  arch/s390/mm/fault.c     | 23 ++++++-----------------
>  2 files changed, 12 insertions(+), 43 deletions(-)
 
Compiles & boots. Comparing old vs. new the same values are
set in siginfo. Looks good.

Acked-by: Martin Schwidefsky >schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
