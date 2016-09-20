Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Sep 2016 14:27:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: migrate exception table users off module.h and
 onto extable.h
In-Reply-To: <20160919215456.5453-1-paul.gortmaker@windriver.com>
References: <20160919215456.5453-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160920142753.374604c1@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 19 Sep 2016 17:54:56 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
> 
> The additions of uaccess.h are to deal with implict includes like:
> 
> arch/s390/kernel/traps.c: In function 'do_report_trap':
> arch/s390/kernel/traps.c:56:4: error: implicit declaration of function 'extable_fixup' [-Werror=implicit-function-declaration]
> arch/s390/kernel/traps.c: In function 'illegal_op':
> arch/s390/kernel/traps.c:173:3: error: implicit declaration of function 'get_user' [-Werror=implicit-function-declaration]
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Added to the linux-s390 tree for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
