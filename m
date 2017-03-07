From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: allow subsystem to be used on m32r and s390 archs
Date: Tue, 7 Mar 2017 14:26:32 -0500
Message-ID: <20170307192632.GC31179@htj.duckdns.org>
References: <CGME20170307135643epcas1p257e7a1e1410a498343b8a6b425df65f2@epcas1p2.samsung.com>
 <2339253.11Ms71o855@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2339253.11Ms71o855@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-ide/>
List-Post: <mailto:linux-ide@vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 07, 2017 at 02:56:40PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Both archs should work just fine with libata subsystem nowadays.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
