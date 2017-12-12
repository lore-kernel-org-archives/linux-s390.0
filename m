Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/dasd: Simplify code
References: <20171209062926.31515-1-christophe.jaillet@wanadoo.fr>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2017 17:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171209062926.31515-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Message-Id: <848960a3-accd-fe90-1b83-da1ae7310915@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hoeppner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09.12.2017 07:29, Christophe JAILLET wrote:
> Use 'seq_printf(m, "...%*phN...")' instead of duplicating its
> implementation.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>

Thanks for the patch. Applied.
