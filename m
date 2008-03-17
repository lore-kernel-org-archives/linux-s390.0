From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [patch 2/2] zcrypt: add support for large random numbers
Date: Mon, 17 Mar 2008 08:02:28 -0700
Message-ID: <47DE8804.9010401@oracle.com>
References: <20080314092523.147382820@de.ibm.com>	 <20080314093046.914555041@de.ibm.com>	 <20080314091402.fa409ac7.randy.dunlap@oracle.com> <1205747051.16137.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1205747051.16137.21.camel@localhost>
Sender: linux-crypto-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-crypto/>
List-Post: <mailto:linux-crypto@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ralph Wuerthner <rwuerthn@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
> On Fri, 2008-03-14 at 09:14 -0700, Randy Dunlap wrote:
>> Linux kernel uses "/**" to indicate the beginning of kernel-doc
>> notation, so when the comment block is not kernel-doc, please don't
>> use that /** to begin the comment block.
>> (multiple occurrences of this)
> 
> True. This is done consistently wrong in the zcrypt driver. I would
> prefer to do a separate kernel-doc cleanup patch and leave this patch as
> it is. Ok ?

Sure.  Thanks.

-- 
~Randy
