From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 03/22] s390: introduce little-endian bitops
Date: Thu, 21 Oct 2010 17:08:00 +0200
Message-ID: <201010211708.00606.arnd@arndb.de>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com> <1287672077-5797-4-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287672077-5797-4-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thursday 21 October 2010, Akinobu Mita wrote:
> Introduce little-endian bit operations by renaming native ext2 bit
> operations. The ext2 bit operations are kept as wrapper macros using
> little-endian bit operations to maintain bisectability until the
> conversions are finished.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
