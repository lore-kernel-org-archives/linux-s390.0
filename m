Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 22 Nov 2018 08:46:46 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] s390: Remove obsolete bust_spinlock() implementation
Message-ID: <20181122164646.GA30230@infradead.org>
References: <20181122141529.14933-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122141529.14933-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please remove the weak attribute from the generic implementation as
well now that the last override is gone.
