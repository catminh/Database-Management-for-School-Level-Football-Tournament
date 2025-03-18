# Database Management for School Level Football Tournament

# Data description
- **Tournament**: UEH organizes a university-level men's football tournament with 8 teams representing 8 faculties.  
- **Teams**: Each faculty has one team, competing in either Group A or B, consisting of 5-12 players (only students from cohort 45 onwards).  
- **Players**: Each player belongs to one team and has a student ID, name, cohort, jersey number, and phone number.  
- **Referees & Stadiums**: A stadium can host multiple matches, and a referee can officiate multiple games.  
- **Format**:  
  - **Group Stage**: 8 teams are divided into 2 groups, playing a round-robin format.  
  - **Semi-Finals**: The top 2 teams from each group advance.  
  - **Third-Place & Final**: The semi-final winners play the final, while the losers compete for third place.  
- **Matches**: Includes match ID, round type (GS, SF, TP, GF), date, time, participating teams, and results.  
- **Results**:  
  - Group stage matches can end in a draw.
  - Knockout matches must have a winner (decided in extra time or penalty shootout if necessary).  
- **Cards**: Players can receive yellow or red cards; 2 yellow cards = 1 indirect red card.  
- **Goals**: Includes goal ID and type (normal, own goal, penalty).  
- **Penalty Shootout**: If a match is tied after extra time, players take penalty kicks until a winner is determined (minimum of 2 rounds).

  # Data Modeling (ERD)
   **Relationships**
  - Relationship 1: Each faculty nominates one team to participate – each team represents only one faculty (1-1).

  - Relationship 2: Each team has a minimum of 5 and a maximum of 12 players – each player can only belong to one team (n-1).

  - Relationship 3: A match takes place in one stadium, but each stadium can host multiple matches (1-n).

  - Relationship 4: A match has one main referee, but a referee can officiate multiple matches (1-n).

  - Relationship 5: Each match involves two teams – each team participates in multiple matches (n-n).

  - Relationship 6: Each match may have multiple penalized players, and each player may receive penalties in multiple matches (n-n).

  - Relationship 7: Each player can score multiple goals, but each goal belongs to one player (n-1).

  - Relationship 8: Each match can have multiple goals, but each goal belongs to one match (n-1).

  - Relationship 9: Each player can take multiple penalty kicks, but each penalty kick belongs to one player (n-1).

  - Relationship 10: Each match can have multiple penalty shootouts, but each shootout belongs to one match (n-1).
  ![image](https://github.com/user-attachments/assets/5eed60db-14cd-44b6-a9d7-c6e7a967597c)

# Converting from ERD to RD
  - Relationship 1,2
  ![image](https://github.com/user-attachments/assets/08d19400-1eb0-4c12-8503-acd705ba4767)
  - Relationship 3,4
  ![image](https://github.com/user-attachments/assets/c1e2c53f-61d7-4434-90b8-27764a9859b6)
  - Relationship 5
  ![image](https://github.com/user-attachments/assets/8d07791b-5065-4e90-a5b9-7b84cc8cddff)
  - Relationship 6
  ![image](https://github.com/user-attachments/assets/b961631d-53ec-4517-a22c-133a0d3d9c11)
  - Relationship 7,8
  ![image](https://github.com/user-attachments/assets/b1a2891d-d188-4f8a-94f8-e0d2b756431a)
  - Relationship 9,10
  ![image](https://github.com/user-attachments/assets/743dc56f-2f56-4e1a-9684-dd71d147125b)

# Data Normalization
  Khoa ( MaKhoa, TenKhoa)
  
   - F= {MaKhoa → TenKhoa}
  
  DoiBong (MaDoi, TenDoi, Bang, MSSVDoiTruong, MaKhoa)
  
   - F= {MaDoi → TenDoi, Bang, MSSVDoiTruong, MaKhoa}
  
  CauThu (MSSV, HoTenSV, Khoa, SoAo, SDTCT, MaDoi, MaKhoa)
  
   - F= { MSSV → HoTenSV, Khoa, SoAo, SDTCT, MaDoi, MaKhoa}
  
  San (MaSan, TenSan, DiaDiem)
  
   - F= {MaSan → TenSan, DiaDiem}
  
  TrongTai (MaTT, HoTenTT, SDTTT)
  
   - F= {MaTT → HoTenTT, SDTTT}
  
  TranDau (MaTD, VongDau, NgayToChuc, GioThiDau, MaSan, MaTT)
  
   - F= {MaTD → VongDau, NgayToChuc, GioThiDau, MaSan, MaTT}
  
  ChiTietTranDau (MaTD, MaDoi, KetQuaDoi, XacDinhKQ)
  
   - F= { MaTD, MaDoi → KetQuaDoi, XacDinhKQ}

  BanThang (MaBT, LoaiBT, MaDoi, MaTD, MSSV)
  
   - F= { MaBT → LoaiBT, MaDoi, MaTD, MSSV}
  
  ThePhat (MSSV, MaTD, SoTheVang, SoTheDo)
  
   - F= { MSSV, MaTD → SoTheVang, SoTheDo}

LuanLuu (MaLL, MSSV, MaTD, TinhTrang)
  
   - F= { MaLL → MSSV, MaTD, TinhTrang}
  * **Step 1: Check for 1NF (First Normal Form)**

      The values of attribute groups in a row are single-valued, with no repeating groups.
      No attribute has a value that can be derived from another attribute.
    
      Conclusion: The database meets 1NF.
   * **Step 2: Check for 2NF (Second Normal Form)**
    
      The database is already in 1NF.
      All non-key attributes are fully functionally dependent on the primary key.
      
      Conclusion: The database meets 2NF.
    
   * **Step 3: Check for 3NF (Third Normal Form)** 
  
      The database is already in 2NF.
      All non-key attributes do not have transitive dependencies on the primary key.
      
      Conclusion: The database meets 3NF.



