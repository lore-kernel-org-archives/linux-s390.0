From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: Tree for Apr 4
Date: Mon, 04 Apr 2016 17:51:09 +0530
Message-ID: <57025C35.6090206@gmail.com>
References: <20160404140951.148c95f6@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160404140951.148c95f6@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday 04 April 2016 09:39 AM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20160401:

s390 allmodconfig build fails with the error:

arch/s390/crypto/ghash_s390.c:14:24: fatal error: crypt_s390.h: No such 
file or directory
  #include "crypt_s390.h"
                       ^

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/120536718

caused by the commit -
ce69a690149c ("s390/crypto: cleanup and move the header with the cpacf 
definitions") which removed the file "crypt_s390.h"

regards
sudip
