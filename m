Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 19 Dec 2018 18:38:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove the ptep_modify_prot_{start,commit} exports
References: <20181219150750.4798-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20181219150750.4798-1-hch@lst.de>
Message-Id: <20181219173852.GA3789@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Christoph Hellwig <hch@lst.de>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 19, 2018 at 04:07:50PM +0100, Christoph Hellwig wrote:
> These two functions are only used by core MM code, so no need to export
> them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/mm/pgtable.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.
